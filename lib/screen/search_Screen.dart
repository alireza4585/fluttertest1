import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertest1/util/image_save.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _getSearchBox(),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection("posts").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()));
                }
                return SliverPadding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      ((context, index) {
                        final snap = snapshot.data!.docs[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.r),
                            ),
                          ),
                          child: CachedImage(
                            imageUrl: snap['postImage'],
                          ),
                        );
                      }),
                      childCount: snapshot.data!.docs.length,
                    ),
                    gridDelegate: SliverQuiltedGridDelegate(
                      crossAxisCount: 3,
                      mainAxisSpacing: 5.h,
                      crossAxisSpacing: 5.h,
                      repeatPattern: QuiltedGridRepeatPattern.inverted,
                      pattern: const [
                        QuiltedGridTile(2, 1),
                        QuiltedGridTile(2, 2),
                        QuiltedGridTile(1, 1),
                        QuiltedGridTile(1, 1),
                        QuiltedGridTile(1, 1),
                      ],
                    ),
                  ),
                );
              })
        ],
      )),
    );
  }

  Widget _getSearchBox() {
    return Container(
      height: 46.h,
      margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(13.r)),
        color: Color(0xff272B40),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(
          children: [
            const Icon(Icons.search),
            SizedBox(
              width: 15.w,
            ),
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search User',
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              width: 15.w,
            ),
          ],
        ),
      ),
    );
  }
}
