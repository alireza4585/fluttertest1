import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest1/data/firebase_servise/firestor.dart';
import 'package:fluttertest1/data/model/user_model.dart';

class Profile_Screen extends StatefulWidget {
  const Profile_Screen({super.key});

  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
  Usermodel? _usermodel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  getdata() async {
    final Firestor_firebase _firestor_firebase = Firestor_firebase();
    Usermodel user = await _firestor_firebase.getusers();
    setState(() {
      _usermodel = user;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: head(_usermodel!),
            ),
            SliverToBoxAdapter(
              child: bio(_usermodel!),
            ),
          ],
        ),
      ),
    );
  }

  Widget bio(Usermodel user) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 13.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user.username,
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
          ),
          Text(
            user.bi,
            style: TextStyle(fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  Widget head(Usermodel user) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
          child: CircleAvatar(
            radius: 43.r,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(user.profileImage),
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
                  user.following.length.toString(),
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 53.w),
                Text(
                  user.followers.length.toString(),
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
