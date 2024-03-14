import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest1/data/firebase_servise/firestor.dart';
import 'package:fluttertest1/util/image_save.dart';
import 'package:fluttertest1/widgets/commentes.dart';
import 'package:fluttertest1/widgets/like_animation.dart';
import 'package:intl/intl.dart';

class Post_widgets extends StatefulWidget {
  final snapshot;
  Post_widgets(this.snapshot, {super.key});

  @override
  State<Post_widgets> createState() => _Post_widgetsState();
}

class _Post_widgetsState extends State<Post_widgets> {
  bool isLikeAnimating = false;
  final user = '';
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final user = _auth.currentUser!.uid;
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 375.w,
          height: 54.h,
          color: Colors.white,
          child: Center(
            child: ListTile(
              leading: ClipOval(
                child: SizedBox(
                  height: 35.h,
                  width: 35.w,
                  child: CachedImage(
                    imageUrl: widget.snapshot['profileImage'],
                  ),
                ),
              ),
              // leading: CircleAvatar(
              //   radius: 16.r,
              //   backgroundColor: Colors.white,
              //   backgroundImage: NetworkImage(
              // widget.snapshot['profileImage'],
              //   ),
              // ),
              title: Text(
                widget.snapshot['username'],
                style: TextStyle(fontSize: 13.sp),
              ),
              subtitle: Text(
                widget.snapshot['location'] ?? '',
                style: TextStyle(fontSize: 11.sp),
              ),
              trailing: const Icon(Icons.more_horiz),
            ),
          ),
        ),
        GestureDetector(
          onDoubleTap: () {
            Firestor_firebase().likePost(
              widget.snapshot['postId'].toString(),
              user,
              widget.snapshot['like'],
              'posts',
            );
            setState(() {
              isLikeAnimating = true;
            });
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 375.h,
                child: CachedImage(
                  imageUrl: widget.snapshot['postImage'],
                ),
              ),
              AnimatedOpacity(
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
            ],
          ),
        ),
        Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 14.h),
              Row(
                children: [
                  SizedBox(width: 14.w),
                  LikeAnimation(
                    isAnimating: widget.snapshot['like'].contains(user),
                    iconlike: true,
                    child: IconButton(
                      icon: widget.snapshot['like'].contains(user)
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.favorite_border,
                            ),
                      onPressed: () => Firestor_firebase().likePost(
                        widget.snapshot['postId'].toString(),
                        user,
                        widget.snapshot['like'],
                        'posts',
                      ),
                    ),
                  ),
                  SizedBox(width: 17.w),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          // barrierColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: DraggableScrollableSheet(
                                initialChildSize: 1,
                                minChildSize: 0.2,
                                maxChildSize: 1,
                                builder: (context, controler) {
                                  return Comment(
                                      widget.snapshot['postId'], 'posts');
                                },
                              ),
                            );
                          });
                    },
                    child: Image.asset(
                      'images/comment.webp',
                      height: 25.h,
                    ),
                  ),
                  SizedBox(width: 17.w),
                  Image.asset('images/send.jpg'),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(right: 15.w),
                    child: Image.asset('images/save.png', height: 25.h),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 19.w, top: 13.5.h, bottom: 5.h),
                child: Text(
                  widget.snapshot['like'].length.toString(),
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  children: [
                    Text(
                      widget.snapshot['username'] + ' ',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.snapshot['caption'],
                      style: TextStyle(
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.w, bottom: 8.h),
                child: Text(
                  'comment',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w300,
                  ),
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15.w, bottom: 8.h, top: 20.h),
          child: Text(
            DateFormat.yMMMd().format(widget.snapshot['time'].toDate()),
            style: TextStyle(
              fontSize: 11.sp,
            ),
          ),
        ),
        const Divider()
      ],
    );
  }
}
