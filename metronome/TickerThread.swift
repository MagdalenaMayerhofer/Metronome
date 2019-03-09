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
    var beats: UInt8 = 1
    private var tickSound: AVAudioPlayer?
    private var tockSound: AVAudioPlayer?
    
    init(bpm: UInt8, beats: UInt8) {
        super.init()
        self.bpm = bpm
        self.beats = beats
        self.start()
    }
    
    override func main() {
        setup()
        var counter: UInt8 = 1
        while self.continueMetronome {
            if let tickSound = tickSound, let tockSound = tockSound {
                if counter == 1 {
                    tickSound.play()
                } else {
                    tockSound.play()
                }
                if counter < beats {
                    counter += 1
                } else {
                    counter = 1
                }
            }
            usleep(UInt32((60.0 / Double(self.bpm)) * 1000000))
        }
    }
    
    private func setup() {
        guard let pathTick = Bundle.main.path(forResource: "tick.m4a", ofType: nil),
            let pathTock = Bundle.main.path(forResource: "tock.m4a", ofType: nil)  else {
            print("ERROR: Could not find tick sound file!")
            return
        }
        
        do {
            tickSound = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: pathTick))
            tockSound = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: pathTock))
        } catch {
            print("ERROR: Could not load tick sound file!")
        }
    }
    
    func stop() {
        continueMetronome = false
    }
}
