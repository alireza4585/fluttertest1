import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest1/screen/home.dart';
import 'package:fluttertest1/screen/profile.dart';

class Navigation_Widget extends StatefulWidget {
  const Navigation_Widget({super.key});

  @override
  State<Navigation_Widget> createState() => _Navigation_WidgetState();
}

int _currentIndex = 0;

class _Navigation_WidgetState extends State<Navigation_Widget> {
  late PageController pageController;
  @override
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
              icon: CircleAvatar(
                radius: 14.0.r,
                backgroundColor: Colors.white,
                backgroundImage: const AssetImage('images/person.png'),
              ),
              label: '',
            ),
          ],
        ),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: const [
          Home_Screen(),
          Home_Screen(),
          Home_Screen(),
          Home_Screen(),
          Profile_Screen(),
        ],
      ),
    );
  }
}
