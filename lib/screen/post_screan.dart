import 'package:flutter/material.dart';
import 'package:fluttertest1/widgets/post.dart';

class PostScreen extends StatelessWidget {
  final snapshot;
  const PostScreen(this.snapshot, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: Post_widgets(snapshot)),
    );
  }
}
