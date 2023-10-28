import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// ignore: camel_case_types
class videoPlayer extends StatefulWidget {
  const videoPlayer(VideoPlayerController controller, {super.key});

  @override
  State<videoPlayer> createState() => _videoPlayerState();
}

// ignore: camel_case_types
class _videoPlayerState extends State<videoPlayer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
    );
  }
}
