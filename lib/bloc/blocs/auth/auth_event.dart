part of 'auth_bloc.dart';

class AuthEvent {}

class SignUpEvent extends AuthEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  SignUpEvent(this.firstName, this.lastName, this.email, this.password);
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent(this.email, this.password);
}

class SignOutEvent extends AuthEvent {
  SignOutEvent();
}