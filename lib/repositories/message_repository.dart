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
          .get();
      messageCollection.docs.forEach((element) {
        messageModelList.add(MessageModel.fromSnap(element));
      });

      return messageModelList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> sendMessage(String id, MessageModel messageModel) async {
    try {
      await firebaseFirestore
          .collection("chat")
          .doc(id)
          .collection("messages")
          .add(messageModel.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
