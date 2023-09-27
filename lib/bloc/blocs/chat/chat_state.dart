part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final List<ChatModel> chatModelList;

  const ChatState({
    List<ChatModel>? chatModelList,
  }) : chatModelList = chatModelList ?? const [];

  ChatState copyWith({
    List<ChatModel>? chatModelList,
  }) {
    return ChatState(
      chatModelList: chatModelList ?? this.chatModelList,
    );
  }

  @override
  List<Object> get props => [chatModelList];
}

class ChatLoading extends ChatState {
  const ChatLoading();

  @override
  List<Object> get props => [];
}

class ChatError extends ChatState {
  final String message;

  const ChatError({
    List<ChatModel>? chatModelList,
    required this.message,
  }) : super(chatModelList: chatModelList);

  @override
  List<Object> get props => [message];
}
