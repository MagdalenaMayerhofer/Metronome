//
//  SoundPlayer.swift
//  metronome
//
//  The class SoundPlayer handles the loading of the audio files for the tick and tock sound of a metronome.
//  It also handles which of the two sounds need to be played.
//
//  Created by Magdalena Mayerhofer on 09.03.19.
//  Copyright © 2019 Magdalena Mayerhofer. All rights reserved.
//

import AVFoundation

class SoundPlayer {
    private var tickSound: AVAudioPlayer?   //  AVAudioPlayer for the tick sound
    private var tockSound: AVAudioPlayer?   //  AVAudioPlayer for the tock sound
    private var beats: UInt8 = 1            //  the number of beats in a measure
    private var counter: UInt8 = 1          //  counts through the measure to know when a new measure begins (tick sound)
    
    //
    //  The init methode loads the tick and tock sound files into AVAudioPlayers.
    //
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
    
    //
    //  The playSound methode plays either the tick or the tock sound.
    //  The counter checks if it should play the first beat of a measure (tick) or every other beat (tock).
    //
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
    
    //
    // The changeBeats methode updates the number of beats in a measure and sets the measure to the begin.
    //
    func changeBeats(beats: UInt8) {
        self.beats = beats
        counter = 1
    }
    
    //
    //  The setMeasureToTheBegin methode sets the measure to the begin.
    //
    func setMeasureToTheBegin() {
        counter = 1
    }
    
    //
    //  The printBeats methode returns the string to display the selected number of beats in a measure.
    //
    func printBeats() -> String {
        if beats == 1 {
            return "\(beats) Beat"
        } else {
            return "\(beats) Beats"
        }
    }
}
