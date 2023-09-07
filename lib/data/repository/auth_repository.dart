import 'package:either_dart/either.dart';
import 'package:fluttertest1/data/datasource/auth_datasource.dart';
import 'package:fluttertest1/util/exception.dart';

abstract class IAuthRepository {
  Future<Either<String, String>> register(
      String email, String password, String passwordConfirme);

  Future<Either<String, String>> login(String email, String password);
}

class AuthRepositoryRemote implements IAuthRepository {
  final IAuthicationDatasource _datasource = AuthecationRemote();
  @override
  Future<Either<String, String>> login(String email, String password) async {
    try {
      await _datasource.login(email, password);
      return const Right('wellcom');
    } on exceptions catch (ex) {
      return Left(ex.massage);
    }
  }

  @override
  Future<Either<String, String>> register(
      String email, String password, String passwordConfirme) async {
    try {
      await _datasource.register(email, password, passwordConfirme);
      return const Right('Register don');
    } on exceptions catch (ex) {
      return Left(ex.massage.toString());
    }
  }
}
