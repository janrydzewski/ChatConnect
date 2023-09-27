import 'package:bloc/bloc.dart';
import 'package:chat_connect/models/models.dart';
import 'package:chat_connect/repositories/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final UserRepository userRepository;

  EditProfileBloc({required this.userRepository}) : super(EditProfileState()) {
    on<EditProfileDetailsEvent>(_onEditProfileDetailsEvent);
    on<EditPhotoEvent>(_onEditPhotoEvent);
  }

  _onEditPhotoEvent(
      EditPhotoEvent event, Emitter<EditProfileState> emit) async {
    emit(EditProfileLoading());
    try {
      emit(state.copyWith(file: event.file));
    } catch (e) {
      emit(EditProfileError(message: e.toString()));
    }
  }

  _onEditProfileDetailsEvent(
      EditProfileDetailsEvent event, Emitter<EditProfileState> emit) async {
    emit(EditProfileLoading());
    try {
      await userRepository.updateUser(event.userModel);
      emit(EditProfileState());
    } catch (e) {
      emit(EditProfileError(message: e.toString()));
    }
  }
}
