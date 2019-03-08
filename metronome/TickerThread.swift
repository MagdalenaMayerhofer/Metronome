//
//  TickerThread.swift
//  metronome
//
//  Created by Magdalena Mayerhofer on 08.03.19.
//  Copyright © 2019 Magdalena Mayerhofer. All rights reserved.
//

import Foundation
import AVFoundation

class TickerThread: Thread {
    private var continueMetronome: Bool = true
    var bpm: UInt8 = 40
    private var tickSound: AVAudioPlayer?
    
    init(bpm: UInt8) {
        super.init()
        self.bpm = bpm
        self.start()
    }
    
    override func main() {
        setup()
        while self.continueMetronome {
            if let tickSound = tickSound {
                tickSound.play()
            }
            usleep(UInt32((60.0 / Double(self.bpm)) * 1000000))
        }
    }
    
    private func setup() {
        guard let path = Bundle.main.path(forResource: "tick.m4a", ofType: nil) else {
            print("ERROR: Could not find tick sound file!")
            return
        }
        
        do {
            tickSound = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
        } catch {
            print("ERROR: Could not load tick sound file!")
        }
    }
    
    func stop() {
        continueMetronome = false
    }
}
