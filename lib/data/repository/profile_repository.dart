import 'package:either_dart/either.dart';
import 'package:fluttertest1/data/firebase_servise/firestor.dart';
import 'package:fluttertest1/data/model/user_model.dart';
import 'package:fluttertest1/util/exception.dart';

abstract class ProfileClass {
  Future<Either<String, Usermodel>> getprofile();
}

class ProfileRepository extends ProfileClass {
  @override
  Future<Either<String, Usermodel>> getprofile() async {
    var response = await Firestor_firebase().getusers();
    try {
      return Right(response);
    } on exceptions catch (e) {
      return Left(e.massage);
    }
  }
}
