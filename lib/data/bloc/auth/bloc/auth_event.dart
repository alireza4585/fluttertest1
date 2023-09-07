// ignore_for_file: camel_case_types

part of 'auth_bloc.dart';

abstract class AuthEvent {}

class Auth_event extends AuthEvent {
  String email;
  String password;
  String passwordConfirme;
  bool login;
  Auth_event(this.email, this.login, this.password, this.passwordConfirme);
}
