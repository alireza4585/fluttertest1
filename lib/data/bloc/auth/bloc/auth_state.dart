// ignore_for_file: must_be_immutable

part of 'auth_bloc.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoding extends AuthState {}

class AuthLogin extends AuthState {
  Either<String, String> login;
  AuthLogin(this.login);
}

class AuthSignup extends AuthState {
  Either<String, String> signUP;
  AuthSignup(this.signUP);
}
