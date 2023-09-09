import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertest1/data/firebase_servise/firestor.dart';
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
    String photoUrl = '';
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (file != File('')) {
          photoUrl =
              await StorageMethods().uploadImageToStorage('profilePics', file);
        } else {
          photoUrl = '';
        }

        await Firestor_firebase().createUser(
          email: email,
          username: username,
          bio: bio,
          prfileImage: photoUrl == ''
              ? 'https://firebasestorage.googleapis.com/v0/b/instagram-8a227.appspot.com/o/person.png?alt=media&token=c6fcbe9d-f502-4aa1-8b4b-ec37339e78ab'
              : photoUrl,
        );
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
