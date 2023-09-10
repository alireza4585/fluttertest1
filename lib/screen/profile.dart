import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profile_Screen extends StatefulWidget {
  const Profile_Screen({super.key});

  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: head(),
            ),
            SliverToBoxAdapter(
              child: bio(),
            ),
          ],
        ),
      ),
    );
  }

  Widget bio() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 13.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'username',
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
          ),
          Text(
            'bio',
            style: TextStyle(fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  Widget head() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
          child: CircleAvatar(
            radius: 43.r,
            backgroundColor: Colors.white,
            backgroundImage: const AssetImage('images/person.png'),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 35.w),
                Text(
                  '0',
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 53.w),
                Text(
                  '0',
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 53.w),
                Text(
                  '0',
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 30.w),
                Text(
                  'post',
                  style: TextStyle(fontSize: 13.sp),
                ),
                SizedBox(width: 18.w),
                Text(
                  'Followers',
                  style: TextStyle(fontSize: 13.sp),
                ),
                SizedBox(width: 12.w),
                Text(
                  'Following',
                  style: TextStyle(fontSize: 13.sp),
                ),
                TextButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    child: Text('out'))
              ],
            ),
          ],
        )
      ],
    );
  }
}
