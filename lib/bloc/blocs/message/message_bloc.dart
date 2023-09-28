import 'package:bloc/bloc.dart';
import 'package:chat_connect/models/models.dart';
import 'package:chat_connect/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository messageRepository;
  MessageBloc({required this.messageRepository}) : super(const MessageState()) {
    on<GetMessagesEvent>(_onGetMessageEvent);
    on<SendMessageEvent>(_onSendMessageEvent);
  }

  _onGetMessageEvent(GetMessagesEvent event, Emitter<MessageState> emit) async {
    emit(const MessageLoading());
    try {
      final messageList = await messageRepository.getMessagesList(event.id);
      emit(MessageState(messageModelList: messageList));
    } catch (e) {
      emit(MessageError(message: e.toString()));
    }
  }

  _onSendMessageEvent(
      SendMessageEvent event, Emitter<MessageState> emit) async {
    emit(const MessageLoading());
    try {
      await messageRepository.sendMessage(event.id, event.messageModel);
      final messageList = await messageRepository.getMessagesList(event.id);
      emit(MessageState(messageModelList: messageList));
    } catch (e) {
      emit(MessageError(message: e.toString()));
    }
  }
}
