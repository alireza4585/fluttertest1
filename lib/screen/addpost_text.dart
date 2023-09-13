import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest1/data/firebase_servise/firestor.dart';
import 'package:fluttertest1/data/firebase_servise/storage.dart';

// ignore: must_be_immutable
class AddpostTextScreen extends StatefulWidget {
  File _file;
  AddpostTextScreen(this._file, {super.key});

  @override
  State<AddpostTextScreen> createState() => _AddpostTextScreenState();
}

class _AddpostTextScreenState extends State<AddpostTextScreen> {
  final caption = TextEditingController();
  final location = TextEditingController();
  bool isloding = false;
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
              child: InkWell(
                onTap: () async {
                  setState(() {
                    isloding = true;
                  });
                  String post_url = await StorageMethods()
                      .uploadImageToStorage('post', widget._file);
                  await Firestor_firebase().createPost(
                    postImage: post_url,
                    caption: caption.text,
                    location: location.text,
                  );

                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
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
        child: isloding
            ? const Center(
                child: CircularProgressIndicator(color: Colors.black),
              )
            : Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
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
