import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:fluttertest1/data/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _repository = AuthRepositoryRemote();
  AuthBloc() : super(AuthInitial()) {
    on<Auth_event>((event, emit) async {
      if (event.login) {
        var loginRepository =
            await _repository.login(event.email, event.password);
        emit(AuthLogin(loginRepository));
      } else {
        var signupRepository = await _repository.register(
            event.email, event.password, event.passwordConfirme);
        emit(AuthSignup(signupRepository));
      }
    });
  }
}
