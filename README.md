# PitchPerfect
PitchPerfect App  

The Pitch Perfect app allows users to record a sound using the device’s microphone. It then allows users to play the recorded sound back with six different sound modulations: Chipmunk, Darth Vader, Super Slow, and Super Fast, Reverb and Eco. The apps stores the last record and able to play the saved record.  
The app has two view controller scenes:  
* **Record Sounds View**: Allows users to record a sound.
* **Play Sounds View**: Allows users to play the recorded sound back with effects.  
  
The two scenes are described in detail below.  
  
####Record Sounds View  
The **record sounds view** is the initial view for the app, and consists of a button with a microphone image. A label indicating the user to tap the button to start recording is beneath the image. Tapping this microphone button starts an audio recording session. The app uses AVFoundation library to record sounds from the microphone.  
Tapping the microphone button disables the record button, display a “recording” label, and presents a stop button.  
When the stop button is clicked, the app completes its recording, it persists the record to device and then push the second scene, namely **Play Sounds View** onto the navigation stack.
  
####Play Sounds View  
The play sounds view has six buttons to play the recorded sound file and a button to stop the playback.  
The buttons for playing the recorded sounds have images corresponding to their sound effect:  
* Chipmunk image → High-pitched sound
* Darth Vader image →  Low-pitched sound
* Snail image → Slow sound
* Rabbit image → Fast sound
* Wave image → Echo sound
* Reverse image → Reverb sound  
  
The **play sounds view** have been pushed onto the navigation stack. At the top left of the screen, clicking the navigation bar’s left button that has the title named “Record” pops the **play sounds view** off the stack and return the user to the **record sounds view**.
Then the microphone button is presented as enabled and the stop button gets hidden.  
  
####Licence  

PitchPerfect created by Mehmet Akif Acar on June 20, 2015.  
Copyright © 2015 Mehmet Akif Acar, www.memetcircus.com. All rights reserved.




