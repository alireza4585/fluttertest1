import 'package:bloc/bloc.dart';
import 'package:fluttertest1/data/bloc/profile/bloc/profile_event.dart';
import 'package:fluttertest1/data/bloc/profile/bloc/profile_state.dart';
import 'package:fluttertest1/data/repository/profile_repository.dart';

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
