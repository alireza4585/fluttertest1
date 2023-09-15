import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertest1/screen/post_screan.dart';
import 'package:fluttertest1/util/image_save.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool show = true;
  final search = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    search.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _getSearchBox(),
          ),
          if (show)
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection("posts").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()));
                }
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
                    gridDelegate: SliverQuiltedGridDelegate(
                      crossAxisCount: 3,
                      mainAxisSpacing: 3.h,
                      crossAxisSpacing: 3.h,
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
              },
            ),
          if (!show)
            StreamBuilder(
              stream: _firestore
                  .collection('users')
                  .where('username', isGreaterThanOrEqualTo: search.text)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()));
                }
                return SliverPadding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 4.w, vertical: 15.h),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final snap = snapshot.data!.docs[index];
                        return Row(
                          children: [
                            CircleAvatar(
                              radius: 23.r,
                              backgroundImage:
                                  NetworkImage(snap['profileImage']),
                            ),
                            SizedBox(width: 15.w),
                            Text(snap['username']),
                          ],
                        );
                      },
                      childCount: snapshot.data!.docs.length,
                    ),
                  ),
                );
              },
            )
        ],
      )),
    );
  }

  Widget _getSearchBox() {
    return Container(
      height: 36.h,
      margin: EdgeInsets.only(left: 4.w, right: 4.w, top: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(13.r)),
        color: Colors.grey[500],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(
          children: [
            const Icon(
              Icons.search,
              color: Colors.white,
            ),
            SizedBox(
              width: 15.w,
            ),
            Expanded(
              child: TextField(
                controller: search,
                onChanged: (value) {
                  setState(() {
                    if (value.length > 0) {
                      show = false;
                    } else {
                      show = true;
                    }
                  });
                },
                decoration: const InputDecoration(
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
