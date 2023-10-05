part of 'message_bloc.dart';

class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class GetMessagesEvent extends MessageEvent {
  final List<MessageModel> messageModelList;
  final String id;
  const GetMessagesEvent(this.messageModelList, this.id);

  @override
  List<Object> get props => [messageModelList, id];
}

class SendMessageEvent extends MessageEvent {
  final String id;
  final MessageModel messageModel;
  const SendMessageEvent(this.id, this.messageModel);

  @override
  List<Object> get props => [id, messageModel];
}
