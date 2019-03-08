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
    @IBOutlet weak var metronomePointer: UIView!
    var bpm: UInt8 = 40
    var tickerThread: TickerThread?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func bpmSliderValueChanged(_ sender: UISlider) {
        bpm = UInt8(sender.value)
        bpmLabel.text = "\(bpm) BPM"
        if let tickerThread = tickerThread {
            tickerThread.bpm = bpm
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if let tickerThread = tickerThread {
            sender.setTitle("Start", for: UIControl.State.normal)
            tickerThread.stop()
            self.tickerThread = nil
        } else {
            sender.setTitle("Stop", for: UIControl.State.normal)
            tickerThread = TickerThread(bpm: bpm)
        }
    }
}

