import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TiktokVideoPlayer extends StatefulWidget {
  TiktokVideoPlayer({super.key, required this.videoUrl});

  String videoUrl;

  @override
  State<TiktokVideoPlayer> createState() => _TiktokVideoPlayerState();
}

class _TiktokVideoPlayerState extends State<TiktokVideoPlayer> {

  late VideoPlayerController videoPlayerController;
  @override
  void initState() {
    super.initState();

    videoPlayerController = VideoPlayerController.network(widget.videoUrl)..initialize().then((value){
      videoPlayerController.play();
    });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.black
      ),
      
      child: VideoPlayer(videoPlayerController),
    );
  }
}
