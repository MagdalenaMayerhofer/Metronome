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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func bpmSliderValueChanged(_ sender: UISlider) {
        bpmLabel.text = "\(Int(sender.value)) BPM"
    }
}

