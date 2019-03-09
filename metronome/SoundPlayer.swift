//
//  SoundPlayer.swift
//  metronome
//
//  Created by Magdalena Mayerhofer on 09.03.19.
//  Copyright © 2019 Magdalena Mayerhofer. All rights reserved.
//

import AVFoundation

class SoundPlayer {
    private var tickSound: AVAudioPlayer?
    private var tockSound: AVAudioPlayer?
    private var beats: UInt8 = 1
    private var counter: UInt8 = 1
    
    init() {
        guard let pathTick = Bundle.main.path(forResource: "tick.m4a", ofType: nil),
          let pathTock = Bundle.main.path(forResource: "tock.m4a", ofType: nil) else {
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
    
    func playSound() {
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
    }
    
    func changeBeats(beats: UInt8) {
        self.beats = beats
        counter = 1
    }
    
    func printBeats() -> String {
        if beats == 1 {
            return "\(beats) Beat"
        } else {
            return "\(beats) Beats"
        }
    }
}
