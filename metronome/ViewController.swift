//
//  ViewController.swift
//  metronome
//
//  Created by Magdalena Mayerhofer on 08.03.19.
//  Copyright © 2019 Magdalena Mayerhofer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var bpmLabel: UILabel!                   //  label to display the selected bpm (beats per minute)
    @IBOutlet weak var beatsLabel: UILabel!                 //  label to display the selected beats per meausure
    @IBOutlet weak var metronomePointer: UIView!            //  the moving pointer of the metronome
    private var timer: Timer = Timer()                      //  the timer for the ticks
    private var soundPlayer: SoundPlayer = SoundPlayer()    //  this object allows to play the sounds
    private var metronomeStarted: Bool = false              //  remembers if the metronome is started or not
    private var bpm: UInt8 = 40                             //  selected value of bpm
    private var directionOfPointer: Int = 1                 //  multiplicator to let the metronome pointer move either to the left or the right
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //
    //  The bpmSliderValueChanged methode is called when the user changes the value of the bpm.
    //  It updates the bpm and label and changes the tempo if the metronome is started.
    //
    @IBAction func bpmSliderValueChanged(_ sender: UISlider) {
        bpm = UInt8(sender.value)
        bpmLabel.text = "\(bpm) BPM"
        
        if metronomeStarted {
            soundPlayer.setMeasureToTheBegin()
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 60.0 / Double(bpm), target: self, selector: #selector(self.metronomeTick), userInfo: nil, repeats: true)
        }
    }
    
    //
    //  The counterSliderValueChanged methode is called when the user changes the number of beats per measure.
    //  It updates the number of beats in the soundPlayer object and updates the label.
    @IBAction func countSliderValueChanged(_ sender: UISlider) {
        soundPlayer.changeBeats(beats: UInt8(sender.value))
        beatsLabel.text = soundPlayer.printBeats()
    }
    
    //
    //  The buttonPressed methode is called when the user presses the start/stop button.
    //  It either starts or stops the metronome and updates the label of the button.
    //
    @IBAction func buttonPressed(_ sender: UIButton) {
        if metronomeStarted {
            sender.setTitle("Start", for: UIControl.State.normal)
            stopMetronome()
        } else {
            sender.setTitle("Stop", for: UIControl.State.normal)
            startMetronome()
        }
    }
    
    //
    //  The startMetronome methode sets the timer and starts the animation of the metronome pointer.
    //
    func startMetronome() {
        UIApplication.shared.isIdleTimerDisabled = true
        metronomeStarted = true
        UIView.animate(withDuration: 60.0 / Double(bpm), animations: {
            self.metronomePointer.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 8)
        })
        self.timer = Timer.scheduledTimer(timeInterval: 60.0 / Double(self.bpm), target: self, selector: #selector(self.metronomeTick), userInfo: nil, repeats: true)
    }
    
    //
    //  The stopMetronome methode stops the timer and stops the animation of the metronome pointer.
    //
    func stopMetronome() {
        UIApplication.shared.isIdleTimerDisabled = false
        metronomeStarted = false
        soundPlayer.setMeasureToTheBegin()
        timer.invalidate()
        UIView.animate(withDuration: 60.0 / Double(bpm) / 2, animations: {
            self.metronomePointer.transform = CGAffineTransform.identity
        })
    }
    
    //
    //  The metronomeTick methode playes the tick or tock sound and continues with the animation.
    //
    @objc func metronomeTick() {
        UIView.animate(withDuration: 60.0 / Double(self.bpm), animations: {
            self.metronomePointer.transform = CGAffineTransform(rotationAngle: CGFloat.pi / CGFloat((8 * self.directionOfPointer)))
            self.soundPlayer.playSound()
            self.directionOfPointer *= -1
        })
    }
}

