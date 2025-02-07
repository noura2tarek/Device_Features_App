import 'dart:developer';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
  final String title;

  const MyHomePage({super.key, required this.title});
}

class _MyHomePageState extends State<MyHomePage> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer _player = FlutterSoundPlayer();

  bool _isRecording = false;
  bool _isPlaying = false;
  bool _isRecordingCompleted = false;
  String? _filePath;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

//----------------- Methods -----------------//
  // Check microphone permission method
  Future<void> _checkPermissions() async {
    var status = await Permission.microphone.request();
    if (status.isDenied) {
      log("The Microphone permission has been denied");
    }
  }

  // Get temporary directory to store audio
  _getTempDir() async {
    Directory tempDir = await getTemporaryDirectory();
    _filePath = '${tempDir.path}/recording.aac';
    setState(() {});
  }

  // initialize method
  Future<void> _initialize() async {
    await _checkPermissions();
    await _recorder.openRecorder();
    await _player.openPlayer();
    // Get temp directory
    _getTempDir();
  }

  // Start recording method
  Future<void> _startRecording() async {
    // Start recording
    await _recorder.startRecorder(
      toFile: _filePath,
      audioSource: AudioSource.microphone,
      codec: Codec.aacADTS,
    );
    setState(() {
      _isRecording = true;
    });
  }

  // Stop recording method
  Future<void> _stopRecording() async {
    await _recorder.stopRecorder();
    setState(() {
      _isRecording = false;
      _isRecordingCompleted = true;
    });
  }

  // Play audio method
  Future<void> _playRecording() async {
    if (_filePath != null) {
      await _player.startPlayer(
          fromURI: _filePath!,
          codec: Codec.aacADTS,
          whenFinished: () {
            setState(() {
              _isPlaying = false;
            });
          });
      setState(() {
        _isPlaying = true;
      });
    }
  }

  // Stop playing audio method
  Future<void> _stopPlayback() async {
    await _player.stopPlayer();
    setState(() {
      _isPlaying = false;
    });
  }

  //---------------- End of Methods -----------------//
  ///////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        elevation: 1.0,
        leading: IconButton(
            onPressed: () {
              // return to first state
              setState(() {
                _isRecordingCompleted = false;
              });
            },
            icon: Icon(Icons.settings_backup_restore)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //-- Record audio button --//
            OutlinedButton.icon(
              icon: Icon(_isRecording ? Icons.stop : Icons.mic),
              onPressed: _isRecording ? _stopRecording : _startRecording,
              label: Text(_isRecording ? "Stop Recording.." : "Record Audio"),
            ),
            // loading indicator
            Visibility(
              visible: _isRecording || _isPlaying,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: LinearProgressIndicator(),
              ),
            ),
            //-- Play Audio button --//
            if (_isRecordingCompleted)
              OutlinedButton.icon(
                icon: Icon(_isPlaying ? Icons.stop : Icons.play_arrow_outlined),
                onPressed: _isPlaying ? _stopPlayback : _playRecording,
                label: Text(_isPlaying ? 'Stop Playing..' : 'Play Audio'),
              ),
          ],
        ),
      ),
    );
  }

  //-- Dispose method --//
  @override
  void dispose() {
    _recorder.closeRecorder();
    _player.closePlayer();
    super.dispose();
  }
}
