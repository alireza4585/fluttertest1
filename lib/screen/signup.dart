import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest1/data/firebase_servise/auth.dart';
import 'package:fluttertest1/util/imagepicker.dart';
import 'package:fluttertest1/util/snakbar.dart';
import 'package:image_picker/image_picker.dart';

// ignore: camel_case_types
class Sign_Screen extends StatefulWidget {
  final VoidCallback show;
  const Sign_Screen(this.show, {super.key});

  @override
  State<Sign_Screen> createState() => _Sign_ScreenState();
}

// ignore: camel_case_types
class _Sign_ScreenState extends State<Sign_Screen> {
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  FocusNode _focusNode3 = FocusNode();
  final email = TextEditingController();
  final password = TextEditingController();
  final passwordConfirme = TextEditingController();
  FocusNode _focusNode4 = FocusNode();
  FocusNode _focusNode5 = FocusNode();
  final username = TextEditingController();
  final bio = TextEditingController();
  bool visibil = true;
  File? _imagefile;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    password.dispose();
    passwordConfirme.dispose();
    bio.dispose();
    username.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(width: 96.w, height: 100.h),
            InkWell(
              onTap: () async {
                File _imagefilee = await utilwidgets().uploadImage('gallery');
                setState(() {
                  _imagefile = _imagefilee;
                });
              },
              child: CircleAvatar(
                radius: 32.r,
                backgroundColor: Colors.grey,
                child: CircleAvatar(
                  radius: 30.r,
                  backgroundColor: Colors.white,
                  backgroundImage: const AssetImage('images/person.png'),
                ),
              ),
            ),
            SizedBox(height: 120.h),
            textfild(email, _focusNode1, 'Email', Icons.email),
            SizedBox(height: 19.h),
            textfild(password, _focusNode2, 'password', Icons.lock),
            SizedBox(height: 19.h),
            textfild(
                passwordConfirme, _focusNode3, 'passwordConfirme', Icons.lock),
            textfild(username, _focusNode4, 'username', Icons.person),
            SizedBox(height: 19.h),
            textfild(bio, _focusNode5, 'bio', Icons.abc),
            SizedBox(height: 25.h),
            SizedBox(height: 40.h),
            signIN(email.text, password.text, passwordConfirme.text,
                username.text, bio.text, _imagefile ?? File('')),
            SizedBox(height: 15.h),
            have(),
          ],
        ),
      ),
    );
  }

  Padding forget() {
    return Padding(
      padding: EdgeInsets.only(left: 220.w),
      child: GestureDetector(
        onTap: () {},
        child: Text(
          'Forgot password?',
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.blue,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Padding have() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Do you have an account?  ",
            style: TextStyle(color: Colors.grey[700], fontSize: 14.sp),
          ),
          GestureDetector(
            onTap: widget.show,
            child: Text(
              "Login",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget signIN(
    String email,
    String password,
    String passwordConfirme,
    String username,
    String bio,
    File file,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () async {
          String respos = await Authecation().Signup(
            email: email,
            password: password,
            username: username,
            bio: bio,
            file: file,
          );

          if (respos != '' && respos != 'sucess')
            utilwidgets().dialogBuilder(context, respos);
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 44.h,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Text(
            'Sign up',
            style: TextStyle(
              color: Colors.white,
              fontSize: 23.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget textfild(TextEditingController controller, FocusNode focusNode,
      String typeName, IconData iconss) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Container(
        height: 44.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: TextField(
          style: TextStyle(fontSize: 18.sp, color: Colors.black),
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: typeName,
            prefixIcon: Icon(
              iconss,
              color: focusNode.hasFocus ? Colors.black : Colors.grey[600],
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: const Color(0xffc5c5c5),
                width: 2.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                width: 2.w,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
