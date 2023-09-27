part of 'user_bloc.dart';

class UserState extends Equatable {
  final UserModel userModel;

  const UserState({
    UserModel? userModel,
  }) : userModel = userModel ?? const UserModel(id: "", firstName: "", lastName: "", email: "", photoUrl: "");

  UserState copyWith({
    UserModel? userModel,
  }) {
    return UserState(
      userModel: userModel ?? this.userModel,
    );
  }

  @override
  List<Object> get props => [userModel];
}

class UserLoading extends UserState {
  const UserLoading();

  @override
  List<Object> get props => [];
}

class UserError extends UserState {
  final String message;

  const UserError({
    UserModel? userModel,
    required this.message,
  }) : super(userModel: userModel);

  @override
  List<Object> get props => [message];
}
