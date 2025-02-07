# Audio Recording and Playing

# General Description

Record an audio and play it back using Flutter Sound.

This is a simple application that enables the user to record his audio and play it back.

*Permission Used**:
1- Record audio permission.
2- Write to external storage permission.
3- Read from external storage.

- Add them in mainfest.xml like this:
  <uses-permission android:name="android.permission.RECORD_AUDIO"/>
  <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
  <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>

-----------------------------

# Explanation

The home screen body contains the 'Record Audio' button to record an audio, and the 'Play Audio'
button to play the recorded audio (this button is appears only after recording an audio).

recording done by using FlutterSoundRecorder().startRecorder() from flutter_sound package.
playing done by using FlutterSoundPlayer().startPlayer() from flutter_sound package.

There is a loading indicator that appears while recording or playing an audio.
After record an audio, the audio saved in temporary directory(using path_provider) to play it back
using player.

The screen output images --> in the assets/images folder.                             
Also, The screen output video --> in the assets folder.

-------------------------

# Packages Used

flutter_sound: for recording and playing audio => https://pub.dev/packages/flutter_sound
path_provider: => https://pub.dev/packages/path_provider
permission_handler: => https://pub.dev/packages/permission_handler
