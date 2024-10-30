import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:work_out/config/Colors.dart';
import 'package:work_out/service/local_storage_service.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  VideoPlayerWidget({required this.videoUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isSliderBeingDragged = false;

  @override
  void initState() {
    super.initState();

    // Force landscape orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    // Initialize the VideoPlayerController with the video URL
    String token = SharedPreferencesService().getValue('token');
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
      httpHeaders: {'x-api-key': token},
    );

    // Initialize the video player
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      // Automatically start playing the video when the widget is loaded
      _controller.play();
      // Ensure the video repeats
      _controller.setLooping(true);
      setState(() {});
    });

    // Add a listener to update the UI when video position changes
    _controller.addListener(() {
      if (!_isSliderBeingDragged) {
        setState(() {}); // Update UI with the current playback position
      }
    });
  }

  @override
  void dispose() {
    // Dispose of the VideoPlayerController to free up resources
    _controller.dispose();

    // Restore to portrait orientation when leaving the video player
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              stops: const [0.45, 1],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                AppColors.darkBlue,
                AppColors.darkBlue.withOpacity(0.05),
              ],
            ),
          ),
          width: double.infinity,
          child: FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // When the video has been successfully loaded
                return Column(
                  mainAxisSize: MainAxisSize
                      .min, // Ensure the column takes only the required space
                  children: [
                    // Ensure the video player scales correctly
                    Flexible(
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                    // Custom seek bar with slider
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 70,
                          ),
                          Text(
                            _formatDuration(_controller.value.position),
                            style: const TextStyle(color: Colors.white),
                          ),
                          Expanded(
                            child: Slider(
                              value: _controller.value.position.inSeconds
                                  .toDouble(),
                              max: _controller.value.duration.inSeconds
                                  .toDouble(),
                              onChanged: (value) {
                                setState(() {
                                  _isSliderBeingDragged = true;
                                  _controller
                                      .seekTo(Duration(seconds: value.toInt()));
                                });
                              },
                              onChangeEnd: (value) {
                                setState(() {
                                  _isSliderBeingDragged = false;
                                  _controller
                                      .seekTo(Duration(seconds: value.toInt()));
                                });
                              },
                              activeColor: Colors.blueAccent,
                              inactiveColor: Colors.grey,
                            ),
                          ),
                          Text(
                            _formatDuration(_controller.value.duration),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                // When the video is still loading
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniStartDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  // Helper function to format Duration to string
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}
