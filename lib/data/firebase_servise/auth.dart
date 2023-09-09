import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertest1/data/firebase_servise/storage.dart';

class Authecation {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> Signup({
    required String email,
    required String password,
    required String username,
    required String bio,
    required File file,
  }) async {
    String respons = '';
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty && file != File('')) {
        await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String photoUrl =
            await StorageMethods().uploadImageToStorage('profilePics', file);
        return respons = 'sucess';
      } else {
        return respons = 'Please enter all the fields';
      }
    } catch (ex) {
      respons = ex.toString();
    }
    return respons;
  }
}
