//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Shubham Tripathi on 04/07/15.
//  Copyright (c) 2015 Shubham Tripathi. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var recievedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if var filePath = recievedAudio.filePathUrl {
        
            audioPlayer = AVAudioPlayer(contentsOfURL: filePath, error: nil)
            audioPlayer.enableRate = true
        }
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: recievedAudio.filePathUrl, error: nil)
    }
    
    
    @IBAction func playSlowAudio(sender: UIButton) {
        playAudioWithVariableRate(0.5)
    }

    @IBAction func playFastAudio(sender: UIButton) {
        playAudioWithVariableRate(2.0)
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        stopResetAudioPlayerAndEngine()
    }
    
    // Stop and Reset audio player and engine
    func stopResetAudioPlayerAndEngine(){
        
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    // Play audio with variable rate
    func playAudioWithVariableRate(rate: Float!) {
        
        stopResetAudioPlayerAndEngine()
        
        // Set the audio playback rate
        audioPlayer.rate = rate
        audioPlayer.play()
    }
    
    // Method to play audio with variable pitch
    func playAudioWithVariablePitch(pitch :Float) {
        
        stopResetAudioPlayerAndEngine()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
