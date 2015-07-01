//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Mehmet Akif Acar on 12/06/15.
//  Copyright (c) 2015 Memetcircus. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder : AVAudioRecorder!
    
    var recordedAudio : RecordedAudio!
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var hideStopButton: UIButton!
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var tapToRecordLabel: UILabel!
   

    @IBAction func recordAudio(sender: UIButton) {
        
        ///do requirements in the interface
        
        recordButton.enabled = false
        tapToRecordLabel.hidden = true
        recordingInProgress.hidden = false
        hideStopButton.hidden = false
        
        
        ///create filepath for recording
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        
        ///setup session
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        
        ///initiliaze and prepare the recorder
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil , error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        
        ///do requirements in the interface
        
        recordingInProgress.hidden = true
        tapToRecordLabel.hidden = false
        
        ///stop the audioRecorder
        
        audioRecorder.stop()
        
        ///Deactivate the session that was setup in recordAudio action
        
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        ///do requirements in the interface
        
        hideStopButton.hidden = true
        recordButton.enabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        ///send recorded data to PlaySoundViewController
        
        if (segue.identifier == "stopRecording" ){
            
            let playSoundsVC : PlaySoundsViewController
            playSoundsVC = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
            
        }
        
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        
        ///save the recorded audio
        
        if(flag){
            
            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }
        else{
            println("Error in recording finished")
            
         ///do requirements in the interface
            
            recordButton.enabled = true
            hideStopButton.enabled = true
        }
    }
    

}



