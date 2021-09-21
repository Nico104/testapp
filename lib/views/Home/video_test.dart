import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

void main() => runApp(ChapterVideoPlayer());

class ChapterVideoPlayer extends StatefulWidget {
  @override
  _ChapterVideoPlayerState createState() => _ChapterVideoPlayerState();
}

class _ChapterVideoPlayerState extends State<ChapterVideoPlayer> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
      _controller!.play();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(100),
          child: Center(
            child: _controller!.value.isInitialized
                ? AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      VideoPlayer(_controller!),
                      VideoProgressIndicator(_controller!, colors: const VideoProgressColors(playedColor: Colors.red, bufferedColor: Colors.purple, backgroundColor: Colors.green),
                      allowScrubbing: true),
                      FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            /*_controller!.value.isPlaying
                                ? _controller!.pause()
                                : _controller!.play();
                            */
                            _controller!.value.playbackSpeed == 1
                                ? _controller!.setPlaybackSpeed(4)
                                : _controller!.setPlaybackSpeed(1);
                          });
                        },
                        child: Icon(
                          _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                        ),
                      ),
                    ],
                  ),
                )
                : Container(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              /*_controller!.value.isPlaying
                  ? _controller!.pause()
                  : _controller!.play();
              */
              _controller!.value.playbackSpeed == 1
                  ? _controller!.setPlaybackSpeed(4)
                  : _controller!.setPlaybackSpeed(1);
            });
          },
          child: Icon(
            _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
        
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }
}