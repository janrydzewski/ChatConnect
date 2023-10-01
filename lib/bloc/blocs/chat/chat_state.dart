part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final List<ChatModel> chatModelList;
  final List<UserModel> receiverUserList;

  const ChatState({
    List<ChatModel>? chatModelList,
    List<UserModel>? receiverUserList,
  })  : chatModelList = chatModelList ?? const [],
        receiverUserList = receiverUserList ?? const [];

  ChatState copyWith({
    List<ChatModel>? chatModelList,
    List<UserModel>? receiverUserList,
  }) {
    return ChatState(
      chatModelList: chatModelList ?? this.chatModelList,
      receiverUserList: receiverUserList ?? this.receiverUserList,
    );
  }

  @override
  List<Object> get props => [chatModelList, receiverUserList];
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
    List<UserModel>? receiverUserList,
    required this.message,
  }) : super(chatModelList: chatModelList, receiverUserList: receiverUserList);

  @override
  List<Object> get props => [message];
}
