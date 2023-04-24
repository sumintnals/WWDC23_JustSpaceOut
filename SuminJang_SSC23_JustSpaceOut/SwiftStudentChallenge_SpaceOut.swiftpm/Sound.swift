//
//  Sound.swift
//  SwiftStudentChallenge
//
//  Created by 장수민 on 2023/04/18.
//

import SwiftUI
import AVFoundation

/*
 Credits:
 [https://freesound.org/s/257958/]
 // switch ON OFF Sound by FillSoko

 [https://freesound.org/s/167304/]
 // Pasture Sound by 2887679652

 [https://freesound.org/s/170515/]
 // AfterRain Sound by rolandasb

 [https://freesound.org/s/167034/]
 // Raining Sound by soundrecorder7

 [https://freesound.org/s/235494/]
 // Umbrella open Sound by ekfink

 [https://freesound.org/s/208890/]
 // Umbrella close Sound by monotoraum

 [https://freesound.org/s/188182/]
 // Sheep Sound by Erokia

 [https://freesound.org/s/245645/]
 // Pop Sound by unfa
 */


class SoundManager: ObservableObject {
    static let instance = SoundManager()
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        case RainSound = "167034_soundrecorder7_light-rain_compress (mp3cut.net)"
        case afterRainSound = "170515__rolandasb__forest_ambient_loop_cut_compress"
        case NightSound = "167304_2887679652_night_crickets_loopable_compress2 (mp3cut.net)"
    }
    
    func playSound(sound: SoundOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".wav") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
}

class SoundEffectManager: ObservableObject {
    static let instance = SoundEffectManager()
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        case PopUPSound = "245645__unfa__cartoon-pop-clean"
        case SheepSound = "188182__erokia__goat-sound-2"
        case PopSound = "257958_fillsoko_light-switch-on-off (mp3cut.net)"
        case PushSound = "257958_fillsoko_light-switch-on-off (mp3cut.net)-2"
        case openUmb = "235494__ekfink__umbrella_open"
        case closeUmb = "208890_monotraum_umbrella-open-close (mp3cut.net)-2"
    }
    
    func playSound(sound: SoundOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".wav") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

