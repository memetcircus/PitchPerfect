//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Mehmet Akif Acar on 17/06/15.
//  Copyright (c) 2015 Memetcircus. All rights reserved.
//

import UIKit
import AVFoundation
import QuartzCore

class PlaySoundsViewController: UIViewController, AVAudioPlayerDelegate {

    var audioPlayer :AVAudioPlayer!
    var receivedAudio : RecordedAudio!
    var audioEngine : AVAudioEngine!
    
    ///used for converting NSURL of receivedAudio to AVAudioFile
    
    var audioFile : AVAudioFile!
    
    @IBAction func playInRabbitMode(sender: UIButton) {
        
        stopAnySound(sender)

        ///play the audio fast
        
        playInWhichRate(2.0)
    }
    
    @IBAction func playInSnailMode(sender: UIButton) {
        
        stopAnySound(sender)
       
        ///play the audio slow
        
        playInWhichRate(0.5)
        
    }
    
    @IBAction func playInChipmunkMode(sender: UIButton) {
        
        stopAnySound(sender)
        
        ///play at high pitch
        
        playAudioWithVariablePitch(1000)
        
    }
    
    
    @IBAction func playInDartVaderMode(sender: UIButton) {
        
        stopAnySound(sender)
        
        ///play at low pitch
        
        playAudioWithVariablePitch(-1000)
        
    }
    
    @IBAction func playInEchoMode(sender: UIButton) {
        
        stopAnySound(sender)
        
        /// play with echo
        
        playAudioWithEcho(100)
    }
   
    ///configures and plays the audio in the desired rate
    
    func playInWhichRate(customRate: Float)
    {
        audioPlayer.stop()
        audioPlayer.rate = customRate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    
    @IBAction func stopAnySound(sender: UIButton) {
        
        makeButtonFadeInFadeOut(sender)
        
        ///stop audioPlayer and Engine
        
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        /// set the audioplayer
        
        audioPlayer = try? AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true
        
        /// create the audioEngine object
        
        audioEngine = AVAudioEngine()
        
        ///create audioFile from recordedAudio's filepathUrl and it is required by audioPlayerNode
        
        audioFile = try? AVAudioFile(forReading: receivedAudio.filePathUrl)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func playAudioWithVariablePitch(pitch: Float){
        
        ///create Node and attach to engine
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        ///create TimePitch and attach to engine
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        ///connect Node with TimePitch and Output
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        ///make ready audioPlayerNode and AudioEngine
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        do {
            try audioEngine.start()
        } catch _ {
        }
        
        ///play the recorded sound
        
        audioPlayerNode.play()
        
    }
    
    
    func playAudioWithEcho(echoLevel: Float){
        
        ///create Node and attach to engine
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        ///create EchoEffect and attach to engine
        
        let addEchoEffect = AVAudioUnitDelay()
        addEchoEffect.wetDryMix = echoLevel
        audioEngine.attachNode(addEchoEffect)
        
        ///connect Node with EchoEffect and Output
        
        audioEngine.connect(audioPlayerNode, to: addEchoEffect, format: nil)
        audioEngine.connect(addEchoEffect, to: audioEngine.outputNode, format: nil)
        
        ///make ready audioPlayerNode and audioEngine
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        do {
            try audioEngine.start()
        } catch _ {
        }
        
        ///play the recorded sound
        
        audioPlayerNode.play()
        
    }
    
    ///add transition effects to button
    
    func makeButtonFadeInFadeOut(sender: UIButton) {
        
        sender.highlighted = false
        
        ///add fade-in effect first and upon the completion add fade-out effect
        
        UIView.animateWithDuration(0.1,
            delay: 0.0,
            options: UIViewAnimationOptions.CurveEaseOut,
            animations: {sender.alpha = 0.0},
            completion:{(finished:Bool) -> Void in
                
                UIView.animateWithDuration(0.1,
                    delay: 0.0,
                    options: UIViewAnimationOptions.CurveEaseIn,
                    animations: {sender.alpha = 1.0},
                    completion: nil)
        })
    }

}
