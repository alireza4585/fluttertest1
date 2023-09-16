import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest1/data/bloc/profile/bloc/profile_bloc.dart';
import 'package:fluttertest1/data/firebase_servise/firestor.dart';
import 'package:fluttertest1/data/model/user_model.dart';
import 'package:fluttertest1/screen/add_post.dart';
import 'package:fluttertest1/screen/home.dart';
import 'package:fluttertest1/screen/profile.dart';
import 'package:fluttertest1/screen/search_Screen.dart';
import 'package:fluttertest1/util/image_save.dart';

class Navigation_Widget extends StatefulWidget {
  const Navigation_Widget({super.key});

  @override
  State<Navigation_Widget> createState() => _Navigation_WidgetState();
}

int _currentIndex = 0;

class _Navigation_WidgetState extends State<Navigation_Widget> {
  final FirebaseFirestore _user = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
    get();
  }

  Usermodel i = Usermodel(
      'username',
      'bi',
      'email',
      'https://firebasestorage.googleapis.com/v0/b/instagram-8a227.appspot.com/o/person.png?alt=media&token=c6fcbe9d-f502-4aa1-8b4b-ec37339e78ab',
      [],
      []);

  void get() async {
    i = await Firestor_firebase().getusers();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _currentIndex = page;
    });
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF833AB4),
              Color(0xFFFD1D1D),
              Color(0xFFF77737),
            ],
          ),
        ),
        child: BottomNavigationBar(
          onTap: navigationTapped,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 28.0.w,
              ),
              label: '',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_outline,
                size: 28.0.w,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ClipOval(
                child: SizedBox(
                  height: 25.h,
                  width: 25.w,
                  child: CachedImage(
                    imageUrl: i.profileImage,
                  ),
                ),
              ),
              label: '',
            ),
          ],
        ),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: [
          const Home_Screen(),
          SearchScreen(),
          const AddPostScreen(),
          const Home_Screen(),
          BlocProvider(
            create: (context) => ProfileBloc(),
            child: const Profile_Screen(),
          ),
        ],
      ),
    );
  }
}
