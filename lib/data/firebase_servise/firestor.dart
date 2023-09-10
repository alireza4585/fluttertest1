import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest1/data/model/user_model.dart';

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

  Future<Usermodel> getusers(AsyncSnapshot snapshot) async {
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
  }
}
