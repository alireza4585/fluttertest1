import 'package:either_dart/either.dart';
import 'package:fluttertest1/data/model/user_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoding extends ProfileState {}

class Profilesuccess extends ProfileState {
  Either<String, Usermodel> user;

  Profilesuccess(this.user);
}
