// ignore_for_file: camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest1/widgets/post.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    print(_auth.currentUser!.uid);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xffFAFAFA),
        title: SizedBox(
          width: 105.w,
          height: 28.h,
          child: Image.asset('images/logo.jpg'),
        ),
        leading: Image.asset('images/camera.jpg'),
        actions: [Image.asset('images/tv.jpg'), Image.asset('images/send.jpg')],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return const Post_widgets();
              },
              childCount: 4,
            ),
          ),
        ],
      ),
    );
  }
}
