part of 'user_bloc.dart';

class UserEvent {
  const UserEvent();
}

class UserDataChanged extends UserEvent {
  final UserModel userData;

  const UserDataChanged(this.userData);
}