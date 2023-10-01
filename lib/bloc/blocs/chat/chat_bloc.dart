import 'package:bloc/bloc.dart';
import 'package:chat_connect/models/models.dart';
import 'package:chat_connect/repositories/repositories.dart';
import 'package:chat_connect/resources/resources.dart';
import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;
  ChatBloc({required this.chatRepository}) : super(const ChatState()) {
    on<GetUserChatsEvent>(_onGetUserChatsEvent);
  }

  _onGetUserChatsEvent(GetUserChatsEvent event, Emitter<ChatState> emit) async {
    emit(const ChatLoading());
    try {
      final chatModelList =
          await chatRepository.getChatModelList(firebaseAuth.currentUser!.uid);
      final receiverUserList =
          await chatRepository.getReceiverNameList(firebaseAuth.currentUser!.uid);
      emit(state.copyWith(chatModelList: chatModelList, receiverUserList: receiverUserList));
    } catch (e) {
      emit(ChatError(message: e.toString()));
    }
  }
}
