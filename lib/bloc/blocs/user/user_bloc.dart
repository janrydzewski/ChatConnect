import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_connect/models/models.dart';
import 'package:chat_connect/repositories/repositories.dart';
import 'package:chat_connect/resources/resources.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  late StreamSubscription<UserModel> userSubscription;

  UserBloc({required this.userRepository}) : super(const UserState()) {
    on<UserDataChanged>(_onUserDataChanged);
    userSubscription = userRepository
        .getUserStream(firebaseAuth.currentUser!.uid)
        .listen((userModel) {
      print(userModel.toString());
      add(UserDataChanged(userModel));
    });
  }

  void _onUserDataChanged(UserDataChanged event, Emitter<UserState> emit) {
    emit(const UserLoading());
    try {
      emit(state.copyWith(userModel: event.userData));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    userSubscription.cancel();
    return super.close();
  }
}
