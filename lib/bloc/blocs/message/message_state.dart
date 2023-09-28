part of 'message_bloc.dart';

class MessageState extends Equatable {
  final List<MessageModel> messageModelList;

  const MessageState({
    List<MessageModel>? messageModelList,
  }) : messageModelList = messageModelList ?? const [];

  MessageState copyWith({
    List<MessageModel>? messageModelList,
  }) {
    return MessageState(
      messageModelList: messageModelList ?? this.messageModelList,
    );
  }

  @override
  List<Object> get props => [messageModelList];
}

class MessageLoading extends MessageState {
  const MessageLoading();

  @override
  List<Object> get props => [];
}

class MessageError extends MessageState {
  final String message;

  const MessageError({
    List<MessageModel>? messageModelList,
    required this.message,
  }) : super(messageModelList: messageModelList);

  @override
  List<Object> get props => [message];
}
