part of 'auth_bloc.dart';

enum AuthStatus { loading, authenticated, unauthenticated, error }

class AuthState extends Equatable {
  final AuthStatus authStatus;
  final String message;

  const AuthState({required this.authStatus, this.message = ""});

  AuthState copyWith({
    AuthStatus? authStatus,
    String? message,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [authStatus, message];
}