//
//  ViewController.swift
//  metronome
//
//  Created by Magdalena Mayerhofer on 08.03.19.
//  Copyright © 2019 Magdalena Mayerhofer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var bpmLabel: UILabel!
    @IBOutlet weak var beatsLabel: UILabel!
    @IBOutlet weak var metronomePointer: UIView!
    private var timer: Timer = Timer()
    private var soundPlayer: SoundPlayer = SoundPlayer()
    private var metronomeStarted: Bool = false
    private var bpm: UInt8 = 40
    private var directionOfPointer: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func bpmSliderValueChanged(_ sender: UISlider) {
        bpm = UInt8(sender.value)
        bpmLabel.text = "\(bpm) BPM"
        
        if metronomeStarted {
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 60.0 / Double(bpm), target: self, selector: #selector(self.animatePointer), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func countSliderValueChanged(_ sender: UISlider) {
        soundPlayer.changeBeats(beats: UInt8(sender.value))
        beatsLabel.text = soundPlayer.printBeats()
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if metronomeStarted {
            sender.setTitle("Start", for: UIControl.State.normal)
            stopMetronome()
        } else {
            sender.setTitle("Stop", for: UIControl.State.normal)
            startMetronome()
        }
    }
    
    func startMetronome() {
        metronomeStarted = true
        UIView.animate(withDuration: 60.0 / Double(bpm), animations: {
            self.metronomePointer.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 8)
        })
        self.timer = Timer.scheduledTimer(timeInterval: 60.0 / Double(self.bpm), target: self, selector: #selector(self.animatePointer), userInfo: nil, repeats: true)
    }
    
    func stopMetronome() {
        metronomeStarted = false
        timer.invalidate()
        UIView.animate(withDuration: 60.0 / Double(bpm) / 2, animations: {
            self.metronomePointer.transform = CGAffineTransform.identity
        })
    }
    
    @objc func animatePointer() {
        UIView.animate(withDuration: 60.0 / Double(self.bpm), animations: {
            self.metronomePointer.transform = CGAffineTransform(rotationAngle: CGFloat.pi / CGFloat((8 * self.directionOfPointer)))
            self.soundPlayer.playSound()
            self.directionOfPointer *= -1
        })
    }
}

