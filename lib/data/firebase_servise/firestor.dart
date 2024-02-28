import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:fluttertest1/data/model/user_model.dart';
import 'package:fluttertest1/util/exception.dart';
import 'package:uuid/uuid.dart';

class Firestor_firebase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<bool> createUser({
    required String email,
    required String username,
    required String bio,
    required String prfileImage,
  }) async {
    await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
      'email': email,
      'username': username,
      'bio': bio,
      'profileImage': prfileImage,
      'followers': [],
      'following': [],
    });
    return true;
  }

  Future<Usermodel> getusers() async {
    // try {
    final user =
        await _firestore.collection('users').doc(_auth.currentUser!.uid).get();
    final snapuser = user.data()!;
    return Usermodel(
      snapuser['username'],
      snapuser['bio'],
      snapuser['email'],
      snapuser['profileImage'],
      snapuser['followers'],
      snapuser['following'],
    );
    // } on FirebaseException catch (e) {
    //   throw exceptions(e.message.toString());
    // }
  }

  // List getAllPost(AsyncSnapshot snapshot) {
  //   try {
  //     final postlist = snapshot.data!.docs.map((doc) {
  //       final snappost = doc.data() as Map<String, dynamic>;
  //       return PostModel(
  //         caption: snappost['caption'],
  //         like: snappost['like'],
  //         location: snappost['location'],
  //         postId: snappost['postId'],
  //         postImage: snappost['postImage'],
  //         profileImage: snappost['profileImage'],
  //         uid: snappost['uid'],
  //         username: snappost['username'],
  //       );
  //     }).toList();
  //     return postlist;
  //   } on FirebaseException catch (e) {
  //     throw exceptions(e.message.toString());
  //   }
  // }

  Future<bool> createPost({
    required String postImage,
    required String caption,
    required String location,
  }) async {
    var uid = const Uuid().v4();
    DateTime data = new DateTime.now();
    Usermodel _usermodel = await getusers();
    await _firestore.collection('posts').doc(uid).set({
      'postImage': postImage,
      'username': _usermodel.username,
      'profileImage': _usermodel.profileImage,
      'caption': caption,
      'location': location,
      'uid': _auth.currentUser!.uid,
      'postId': uid,
      'like': [],
      'time': data
    });
    return true;
  }

  Future<bool> createReel({
    required String ReelVideo,
    required String caption,
  }) async {
    var uid = const Uuid().v4();
    DateTime data = new DateTime.now();
    Usermodel _usermodel = await getusers();
    await _firestore.collection('Reels').doc(uid).set({
      'ReelVideo': ReelVideo,
      'username': _usermodel.username,
      'profileImage': _usermodel.profileImage,
      'caption': caption,
      'uid': _auth.currentUser!.uid,
      'ReelId': uid,
      'like': [],
      'time': data
    });
    return true;
  }

  Future<bool> comment({
    required String comment,
    required String type,
    required String uid,
  }) async {
    var uidd = const Uuid().v4();
    DateTime data = new DateTime.now();
    Usermodel _usermodel = await getusers();
    await _firestore
        .collection(type)
        .doc(uid)
        .collection('comment')
        .doc(uidd)
        .set({
      'username': _usermodel.username,
      'profileImage': _usermodel.profileImage,
      'comment': comment,
      'commentUid': uidd,
    });
    return true;
  }
}
