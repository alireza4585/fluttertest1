import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest1/util/image_save.dart';

class Post_widgets extends StatefulWidget {
  final snapshot;
  Post_widgets(this.snapshot, {super.key});

  @override
  State<Post_widgets> createState() => _Post_widgetsState();
}

class _Post_widgetsState extends State<Post_widgets> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 375.w,
          height: 54.h,
          color: Colors.white,
          child: Center(
            child: ListTile(
              leading: CircleAvatar(
                radius: 16.r,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                  widget.snapshot['profileImage'],
                ),
              ),
              title: Text(
                widget.snapshot['username'],
                style: TextStyle(fontSize: 13.sp),
              ),
              subtitle: Text(
                widget.snapshot['location'],
                style: TextStyle(fontSize: 11.sp),
              ),
              trailing: const Icon(Icons.more_horiz),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 375.h,
          child: CachedImage(
            imageUrl: widget.snapshot['postImage'],
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
                  const Icon(Icons.favorite_outline),
                  SizedBox(width: 17.w),
                  Image.asset(
                    'images/comment.webp',
                    height: 25.h,
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
        const Divider()
      ],
    );
  }
}
