import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest1/data/firebase_servise/firestor.dart';
import 'package:fluttertest1/data/firebase_servise/storage.dart';
import 'package:fluttertest1/screen/addPost/addpost_text.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class VideoView extends StatefulWidget {
  File videoFile;
  VideoView(this.videoFile, {super.key});

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  final caption = TextEditingController();
  final location = TextEditingController();
  bool isloding = false;
  late VideoPlayerController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = VideoPlayerController.file(widget.videoFile)
      ..initialize().then((_) {
        setState(() {});
        controller.setLooping(true);
        controller.setVolume(1.0); // Adjust the volume here (0.0 to 1.0)
        controller.play();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'New Reels',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Center(
            child: isloding
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.black),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          isloding = true;
                        });
                        // File compressFile =
                        //     await _compressVideo(widget.videoFile.toString());
                        // print(compressFile);
                        String Reel_url = await StorageMethods()
                            .uploadImageToStorage('Reels', widget.videoFile);
                        await Firestor_firebase().createReel(
                          ReelVideo: Reel_url,
                          caption: caption.text,
                        );

                        // // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Share',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
          ),
          // )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Container(
                  width: 270.w,
                  height: 450.h,
                  decoration: BoxDecoration(
                    // color: Colors.amber,
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  child: controller.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: controller.value.aspectRatio,
                          child: VideoPlayer(controller),
                        )
                      : const CircularProgressIndicator(),
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                height: 60.h,
                width: 280.w,
                child: TextField(
                  controller: caption,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    hintText: 'Write a caption...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const Divider(),
              // SizedBox(
              //   height: 30.h,
              //   width: 280.w,
              //   child: TextField(
              //     controller: location,
              //     maxLines: 1,
              //     decoration: const InputDecoration(
              //       hintText: 'Add location',
              //       border: InputBorder.none,
              //     ),
              //   ),
              // ),
              // const Divider(),
            ],
          ),
        ),
      ),
    );
  }

  _compressVideo(String videoPath) async {
    final compressvideo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.MediumQuality,
    );
    return compressvideo!.file;
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose(); // Dispose the controller to release resources
  }
}
