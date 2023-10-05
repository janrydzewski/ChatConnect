part of 'chat_bloc.dart';

class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class GetUserChatsEvent extends ChatEvent {
  final List<ChatModel> chatModelList;
  const GetUserChatsEvent(this.chatModelList);

  @override
  List<Object> get props => [chatModelList];
}
