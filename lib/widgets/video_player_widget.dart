import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  final snapshot;
  VideoPlayerItem(this.snapshot, {super.key});

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController controller;
  void initState() {
    // TODO: implement initState
    super.initState();
    // ignore: deprecated_member_use
    controller = VideoPlayerController.network(widget.snapshot['ReelVideo'])
      ..initialize().then((_) {
        setState(() {});
        controller.setLooping(true);
        controller.setVolume(1.0); // Adjust the volume here (0.0 to 1.0)
        controller.play();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: double.infinity,
          height: 812.h,
          decoration: BoxDecoration(color: Colors.black),
          child: VideoPlayer(controller),
        ),
        Positioned(
          top: 450.h,
          right: 15.w,
          child: Column(
            children: [
              SizedBox(
                height: 8.h,
              ),
              Container(
                child: Column(
                  children: [
                    Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 28.w,
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      '0',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                child: Column(
                  children: [
                    Icon(
                      Icons.comment,
                      color: Colors.white,
                      size: 28.w,
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      '0',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                child: Column(
                  children: [
                    Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 28.w,
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      '0',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
