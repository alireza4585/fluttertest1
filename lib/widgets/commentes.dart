import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest1/data/firebase_servise/firestor.dart';
import 'package:fluttertest1/util/image_save.dart';

class Comment extends StatefulWidget {
  String uid;
  String type;
  Comment(this.uid, this.type, {super.key});

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isloding = false;
  final comment = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25.r),
        topRight: Radius.circular(25.r),
      ),
      child: Container(
        color: Colors.white,
        height: 300.h,
        child: Stack(
          children: [
            Positioned(
              top: 8.h,
              left: 140.w,
              child: Container(width: 100.w, height: 3.h, color: Colors.black),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection(widget.type)
                  .doc(widget.uid)
                  .collection('comment')
                  .snapshots(),
              builder: (context, snapshot) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      }
                      if (snapshot.data!.docs.length < 0) {
                        return Text('nothing for watch');
                      }

                      return comment_item(snapshot.data!.docs[index].data());
                    },
                    itemCount:
                        snapshot.data == null ? 0 : snapshot.data!.docs.length,
                  ),
                );
              },
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Container(
                  color: Colors.white,
                  height: 60.h,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 45.h,
                        width: 270.w,
                        child: TextField(
                          controller: comment,
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: 'Your comment..',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            isloding = true;
                          });
                          if (comment.text.isNotEmpty) {
                            await Firestor_firebase().comment(
                              comment: comment.text,
                              uid: widget.uid,
                              type: widget.type,
                            );
                          }
                          setState(() {
                            isloding = false;
                            comment.clear();
                          });
                        },
                        child: isloding
                            ? SizedBox(
                                height: 15.h,
                                width: 15.h,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.w,
                                ))
                            : const Icon(Icons.send),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget comment_item(final snapshots) {
    return ListTile(
      leading: ClipOval(
        child: SizedBox(
          height: 30.h,
          width: 30.w,
          child: CachedImage(
            imageUrl: snapshots['profileImage'],
          ),
        ),
      ),
      title: Text(
        snapshots['username'],
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        snapshots['comment'],
        style: TextStyle(
          fontSize: 13.sp,
          color: Colors.black,
        ),
      ),
    );
  }
}
