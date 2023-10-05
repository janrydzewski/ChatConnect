import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_connect/models/models.dart';
import 'package:chat_connect/repositories/repositories.dart';
import 'package:chat_connect/resources/resources.dart';
import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;
  late StreamSubscription<List<ChatModel>> listChatModelSubscription;

  ChatBloc({required this.chatRepository}) : super(const ChatState()) {
    on<GetUserChatsEvent>(_onGetUserChatsEvent);
    listChatModelSubscription = chatRepository
        .getChatModelListStream(firebaseAuth.currentUser!.uid)
        .listen((List<ChatModel> chatModelList) {
      print(chatModelList.toString());
      add(GetUserChatsEvent(chatModelList));
    });
  }

  _onGetUserChatsEvent(GetUserChatsEvent event, Emitter<ChatState> emit) async {
    emit(const ChatLoading());
    try {
      final receiverUserList = await chatRepository
          .getReceiverNameList(firebaseAuth.currentUser!.uid);
      emit(state.copyWith(
          chatModelList: event.chatModelList, receiverUserList: receiverUserList));
    } catch (e) {
      emit(ChatError(message: e.toString()));
    }
  }
}
