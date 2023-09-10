import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest1/data/firebase_servise/storage.dart';

class AddpostTextScreen extends StatefulWidget {
  File _file;
  AddpostTextScreen(this._file, {super.key});

  @override
  State<AddpostTextScreen> createState() => _AddpostTextScreenState();
}

class _AddpostTextScreenState extends State<AddpostTextScreen> {
  final caption = TextEditingController();
  final location = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'New Post',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: GestureDetector(
                onTap: () async {
                  String post_url = await StorageMethods()
                      .uploadImageToStorage('post', widget._file);
                },
                child: Text(
                  'Share',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                child: Row(
                  children: [
                    Container(
                      height: 65.h,
                      width: 65.w,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        image: DecorationImage(
                          image: FileImage(widget._file),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    SizedBox(
                      height: 60.h,
                      width: 280.w,
                      child: TextField(
                        controller: caption,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          hintText: 'Write acaption...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: SizedBox(
                  height: 30.h,
                  width: 280.w,
                  child: TextField(
                    controller: location,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      hintText: 'Add location',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
