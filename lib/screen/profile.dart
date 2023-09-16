import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest1/data/bloc/profile/bloc/profile_bloc.dart';
import 'package:fluttertest1/data/bloc/profile/bloc/profile_event.dart';
import 'package:fluttertest1/data/bloc/profile/bloc/profile_state.dart';
import 'package:fluttertest1/data/model/user_model.dart';
import 'package:fluttertest1/screen/post_screan.dart';
import 'package:fluttertest1/util/image_save.dart';

class Profile_Screen extends StatefulWidget {
  const Profile_Screen({super.key});

  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int post = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ProfileBloc>(context).add(profileImitilzeData());
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                if (state is ProfileInitial) ...{
                  const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                } else if (state is Profilesuccess) ...{
                  state.user.fold((left) {
                    print(left);
                    return const SliverToBoxAdapter(child: Text(''));
                  }, (right) {
                    return SliverToBoxAdapter(
                      child: head(right),
                    );
                  })
                },
                StreamBuilder(
                  stream: _firebaseFirestore
                      .collection('posts')
                      .where('uid', isEqualTo: _auth.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const SliverToBoxAdapter(
                          child: Center(child: CircularProgressIndicator()));
                    }
                    post = snapshot.data!.docs.length;
                    return SliverPadding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 10.h),
                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          ((context, index) {
                            final snap = snapshot.data!.docs[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PostScreen(snap.data()),
                                ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.r),
                                  ),
                                ),
                                child: CachedImage(
                                  imageUrl: snap['postImage'],
                                ),
                              ),
                            );
                          }),
                          childCount: snapshot.data!.docs.length,
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 4.w,
                          mainAxisSpacing: 4.h,
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget head(Usermodel user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
              child: ClipOval(
                child: SizedBox(
                  height: 80.h,
                  width: 80.w,
                  child: CachedImage(
                    imageUrl: user.profileImage,
                  ),
                ),
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
                      post.toString(),
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 53.w),
                    Text(
                      user.following.length.toString(),
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 53.w),
                    Text(
                      user.followers.length.toString(),
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold),
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
                  ],
                ),
              ],
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 13.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.username,
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 3.h),
              Text(
                user.bi,
                style: TextStyle(fontSize: 12.sp),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
