// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
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
  // ignore: unused_field
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  // ignore: override_on_non_overriding_member
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
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
          StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection("posts")
                .orderBy("time", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    if (snapshot.data!.docs.length < 0) {
                      return SliverToBoxAdapter(
                        child: Text('nothing for watch'),
                      );
                    }
                    // final getpost = Firestor_firebase().getAllPost(snapshot);
                    // print(getpost[0].caption);
                    return Post_widgets(snapshot.data!.docs[index].data());
                  },
                  childCount:
                      snapshot.data == null ? 0 : snapshot.data!.docs.length,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
