
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerScreen extends StatefulWidget {
  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();

    // Listen to audio duration
    _audioPlayer.onDurationChanged.listen((d) {
      setState(() {
        duration = d;
      });
    });

    // Listen to audio position
    _audioPlayer.onPositionChanged.listen((p) {
      setState(() {
        position = p;
      });
    });

    // Listen to player state
    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  // Format duration to mm:ss
  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Player'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Audio title
            const Text(
              'My Audio',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),

            // Slider
            Slider(
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) async {
                final newPosition = Duration(seconds: value.toInt());
                await _audioPlayer.seek(newPosition);
              },
            ),

            // Time labels
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatTime(position)),
                  Text(formatTime(duration)),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Play/Pause button
            CircleAvatar(
              radius: 35,
              backgroundColor: Colors.blue,
              child: IconButton(
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 40,
                ),
                color: Colors.white,
                onPressed: () async {
                  if (isPlaying) {
                    await _audioPlayer.pause();
                  } else {
                    // Replace with your audio URL or asset
                    await _audioPlayer.play(UrlSource(
                       'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3'

                    ));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
