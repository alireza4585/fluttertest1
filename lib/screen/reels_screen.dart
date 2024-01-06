import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest1/widgets/video_player.dart';
import 'package:fluttertest1/widgets/video_player_widget.dart';
import 'package:video_player/video_player.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  @override
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore
              .collection('Reels')
              .orderBy("time", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            return PageView.builder(
              controller: PageController(
                initialPage: 0,
                viewportFraction: 1,
              ),
              itemBuilder: (context, index) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                if (snapshot.data!.docs.length < 0) {
                  return SliverToBoxAdapter(
                    child: Text('nothing for watch'),
                  );
                }
                // final getpost = Firestor_firebase().getAllPost(snapshot);
                // print(getpost[0].caption);
                return VideoPlayerItem(snapshot.data!.docs[index].data());
              },
              itemCount: snapshot.data == null ? 0 : snapshot.data!.docs.length,
            );
          },
        ),
      ),
    );
  }
}
