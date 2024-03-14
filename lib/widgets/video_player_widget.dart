import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest1/data/firebase_servise/firestor.dart';
import 'package:fluttertest1/util/image_save.dart';
import 'package:fluttertest1/widgets/commentes.dart';
import 'package:fluttertest1/widgets/like_animation.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  final snapshot;
  VideoPlayerItem(this.snapshot, {super.key});

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController controller;
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool paly = true;
  final user = '';
  bool isLikeAnimating = false;
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
    final user = _auth.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        GestureDetector(
          onDoubleTap: () {
            Firestor_firebase().likePost(
              widget.snapshot['ReelId'].toString(),
              user,
              widget.snapshot['like'],
              'Reels',
            );
            setState(() {
              isLikeAnimating = true;
            });
          },
          onTap: () {
            setState(() {
              paly = !paly;
            });
            if (paly == true) {
              controller.play();
            } else if (paly == false) {
              controller.pause();
            }
          },
          child: Container(
            width: double.infinity,
            height: 812.h,
            decoration: BoxDecoration(color: Colors.black),
            child: VideoPlayer(controller),
          ),
        ),
        if (paly == false)
          Center(
            child: CircleAvatar(
              backgroundColor: Colors.white30,
              radius: 35.r,
              child: Icon(
                Icons.pause,
                size: 35.w,
                color: Colors.white,
              ),
            ),
          ),
        Center(
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: isLikeAnimating ? 1 : 0,
            child: LikeAnimation(
              isAnimating: isLikeAnimating,
              duration: const Duration(
                milliseconds: 400,
              ),
              onEnd: () {
                setState(() {
                  isLikeAnimating = false;
                });
              },
              child: const Icon(
                Icons.favorite,
                color: Colors.white,
                size: 100,
              ),
            ),
          ),
        ),
        Positioned(
          top: 430.h,
          right: 15.w,
          child: Column(
            children: [
              SizedBox(
                height: 8.h,
              ),
              Container(
                child: Column(
                  children: [
                    LikeAnimation(
                      isAnimating: widget.snapshot['like'].contains(user),
                      iconlike: true,
                      child: IconButton(
                        icon: widget.snapshot['like'].contains(user)
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 30,
                              )
                            : const Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                                size: 30,
                              ),
                        onPressed: () => Firestor_firebase().likePost(
                          widget.snapshot['ReelId'].toString(),
                          user,
                          widget.snapshot['like'],
                          'Reels',
                        ),
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      widget.snapshot['like'].length.toString(),
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
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            // barrierColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: DraggableScrollableSheet(
                                  initialChildSize: 1,
                                  minChildSize: 0.2,
                                  maxChildSize: 1,
                                  builder: (context, controler) {
                                    return Comment(
                                        widget.snapshot['ReelId'], 'Reels');
                                  },
                                ),
                              );
                            });
                      },
                      child: Icon(
                        Icons.comment,
                        color: Colors.white,
                        size: 28.w,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      widget.snapshot['like'].length.toString(),
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
        Positioned(
          bottom: 40.h,
          left: 10.w,
          right: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipOval(
                    child: SizedBox(
                      height: 35.h,
                      width: 35.w,
                      child: CachedImage(
                        imageUrl: widget.snapshot['profileImage'],
                      ),
                    ),
                  ),
                  SizedBox(width: 10.h),
                  Text(
                    widget.snapshot['username'],
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10.h),
                  Container(
                    alignment: Alignment.center,
                    width: 60.w,
                    height: 25.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Text(
                      'Follow',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8.h,
                width: 10.w,
              ),
              Text(
                widget.snapshot['caption'],
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
