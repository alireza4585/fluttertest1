import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:fluttertest1/data/bloc/profile/bloc/profile_state.dart';
import 'package:fluttertest1/data/model/user_model.dart';
import 'package:fluttertest1/data/repository/profile_repository.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileClass _profileClass = ProfileRepository();
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      emit(ProfileLoding());
      var prfile_user = await _profileClass.getprofile();
      emit(Profilesuccess(prfile_user));
    });
  }
}
