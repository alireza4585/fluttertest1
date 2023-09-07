import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Post_widgets extends StatefulWidget {
  const Post_widgets({super.key});

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
                backgroundImage: const AssetImage('images/person.png'),
              ),
              title: Text(
                'name',
                style: TextStyle(fontSize: 13.sp),
              ),
              subtitle: Text(
                'location',
                style: TextStyle(fontSize: 11.sp),
              ),
              trailing: const Icon(Icons.more_horiz),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 375.h,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/image.jpeg'),
              fit: BoxFit.cover,
            ),
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
                padding:
                    EdgeInsets.symmetric(horizontal: 15.w, vertical: 13.5.h),
                child: Text(
                  'Like: 22',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
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
