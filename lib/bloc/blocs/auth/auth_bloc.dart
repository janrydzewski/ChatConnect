import 'package:bloc/bloc.dart';
import 'package:chat_connect/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository})
      : super(const AuthState(authStatus: AuthStatus.unauthenticated)) {
    on<SignInEvent>(_onSignInEvent);
    on<SignUpEvent>(_onSignUpEvent);
    on<SignOutEvent>(_onSignOutEvent);
  }

  _onSignInEvent(SignInEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));
    try {
      await authRepository.signIn(email: event.email, password: event.password);
      print("Sign In success: ${event.email} ${event.password}");
      emit(state.copyWith(authStatus: AuthStatus.authenticated));
    } catch (e) {
      emit(state.copyWith(authStatus: AuthStatus.error, message: e.toString()));
      emit(state.copyWith(authStatus: AuthStatus.unauthenticated));
    }
  }

  _onSignUpEvent(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));
    try {
      await authRepository.signUp(
          firstName: event.firstName,
          lastName: event.lastName,
          email: event.email,
          password: event.password);
      print("Sign Up success: ${event.email} ${event.password}");
      emit(state.copyWith(authStatus: AuthStatus.authenticated));
    } catch (e) {
      emit(state.copyWith(authStatus: AuthStatus.error, message: e.toString()));
      emit(state.copyWith(authStatus: AuthStatus.unauthenticated));
    }
  }

  _onSignOutEvent(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));
    await authRepository.signOut();
    emit(state.copyWith(authStatus: AuthStatus.unauthenticated));
  }
  
}
