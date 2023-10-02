// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:chat_connect/models/models.dart';
import 'package:chat_connect/resources/resources.dart';

class MessageRepository {
  const MessageRepository();

  Future<List<MessageModel>> getMessagesList(String id) async {
    List<MessageModel> messageModelList = [];

    try {
      final messageCollection = await firebaseFirestore
          .collection("chat")
          .doc(id)
          .collection("messages")
          .orderBy("date", descending: false)
          .get();
      for (var element in messageCollection.docs) {
        messageModelList.add(MessageModel.fromSnap(element));
      }
      return messageModelList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> sendMessage(String id, MessageModel messageModel) async {
    try {
      final documentRef = await firebaseFirestore
          .collection("chat")
          .doc(id)
          .collection("messages")
          .add(messageModel.toMap());

      await firebaseFirestore
          .collection("chat")
          .doc(id)
          .collection("messages")
          .doc(documentRef.id)
          .update({"id": documentRef.id});

      await firebaseFirestore
          .collection("chat")
          .doc(id)
          .update({"lastMessage": messageModel.message, "lastSender": messageModel.senderUid, "lastMessageDate": messageModel.date.millisecondsSinceEpoch});

    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
