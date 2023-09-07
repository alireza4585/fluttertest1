import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertest1/util/exception.dart';

abstract class IAuthicationDatasource {
  Future<void> register(String email, String password, String passwordConfirme);
  Future<void> login(String email, String password);
}

class AuthecationRemote implements IAuthicationDatasource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on FirebaseAuthException catch (e) {
      throw exceptions(e.message.toString());
    }
  }

  @override
  Future<void> register(
      String email, String password, String passwordConfirme) async {
    try {
      if (password == passwordConfirme) {
        await _auth.createUserWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
        );
      }
    } on FirebaseAuthException catch (e) {
      throw exceptions(e.message.toString());
    } catch (e) {
      throw exceptions('password and passwordconfirm not same');
    }
  }
}
