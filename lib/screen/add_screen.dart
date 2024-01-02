import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest1/screen/addPost/add_post.dart';
import 'package:fluttertest1/screen/reels/add_reels_scree.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

int _currentIndex = 0;

class _AddScreenState extends State<AddScreen> {
  @override
  late PageController pageController;
  void initState() {
    super.initState();
    pageController = PageController();
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

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView(
              controller: pageController,
              onPageChanged: onPageChanged,
              children: [
                AddPostScreen(),
                AddReelsScreen(),
              ],
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              bottom: 10.h,
              right: _currentIndex == 0 ? 100.w : 150.w,
              child: Container(
                width: 120.w,
                height: 30.h,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20.r)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        navigationTapped(0);
                      },
                      child: Text(
                        'Post',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color:
                              _currentIndex == 0 ? Colors.white : Colors.grey,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        navigationTapped(1);
                      },
                      child: Text(
                        'Reels',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color:
                              _currentIndex == 1 ? Colors.white : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
