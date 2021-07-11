//
//  SoundManager.swift
//  Main Road
//
//  Created by Konstantin Dmitrievskiy on 11.07.2021.
//
import AVFoundation
import Foundation

class SoundManager {
    var soundPlayers = [String: AVAudioPlayer]()

    func startLoopingSound(fileName: String, volume: Float) {
        let player = playerForFile(fileName: fileName)
        player.volume = volume
        player.numberOfLoops = -1
        player.play()
    }

    func stopLoopingSound(fileName: String) {
        playerForFile(fileName: fileName).stop()
    }

    func playSound(fileName: String) {
        let player = playerForFile(fileName: fileName)
        player.play()
    }

    private func playerForFile(fileName: String) -> AVAudioPlayer {
        if let existingPlayer = soundPlayers[fileName] {
            return existingPlayer
        }
        let fileURL = Bundle.main.url(forResource: fileName, withExtension: nil)!
        let newPlayer = try! AVAudioPlayer(contentsOf: fileURL)
        soundPlayers[fileName] = newPlayer
        return newPlayer
    }
}
