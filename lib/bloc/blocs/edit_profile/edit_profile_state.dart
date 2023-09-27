part of 'edit_profile_bloc.dart';

class EditProfileState extends Equatable{
  final XFile file;

  EditProfileState({XFile? file, bool? isLoaded}) : file = file ?? XFile("");

  EditProfileState copyWith({
    XFile? file,
  }) {
    return EditProfileState(
      file: file ?? this.file,
    );
  }

  @override
  List<Object> get props => [file];
}

class EditProfileLoading extends EditProfileState {}

class EditProfileError extends EditProfileState {
  final String message;

  EditProfileError({
    XFile? file,
    required this.message,
  }) : super(
          file: file,
        );
}
