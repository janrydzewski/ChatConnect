part of 'edit_profile_bloc.dart';

class EditProfileEvent {
  const EditProfileEvent();
}

class EditProfileDetailsEvent extends EditProfileEvent {
  final UserModel userModel;

  const EditProfileDetailsEvent(this.userModel);
}

class EditPhotoEvent extends EditProfileEvent {
  final XFile file;

  const EditPhotoEvent(this.file);
}