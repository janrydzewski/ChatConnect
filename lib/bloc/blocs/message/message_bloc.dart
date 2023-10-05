import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_connect/models/models.dart';
import 'package:chat_connect/repositories/repositories.dart';
import 'package:chat_connect/resources/resources.dart';
import 'package:equatable/equatable.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository messageRepository;
  final String roomId;
  late StreamSubscription<List<MessageModel>> listMessageModelSubscription;

  MessageBloc({required this.messageRepository, required this.roomId}) : super(const MessageState()) {
    on<GetMessagesEvent>(_onGetMessageEvent);
    on<SendMessageEvent>(_onSendMessageEvent);
    listMessageModelSubscription = messageRepository
        .getMessagesListStream(roomId)
        .listen((List<MessageModel> messageModelList) {
      print(messageModelList.toString());
      add(GetMessagesEvent(messageModelList, roomId));
    });
  }

  _onGetMessageEvent(GetMessagesEvent event, Emitter<MessageState> emit) async {
    emit(const MessageLoading());
    try {
      emit(MessageState(messageModelList: event.messageModelList));
    } catch (e) {
      emit(MessageError(message: e.toString()));
    }
  }

  _onSendMessageEvent(
      SendMessageEvent event, Emitter<MessageState> emit) async {
    emit(const MessageLoading());
    try {
      await messageRepository.sendMessage(event.id, event.messageModel);
      emit(MessageState(messageModelList: []));
    } catch (e) {
      emit(MessageError(message: e.toString()));
    }
  }
}
