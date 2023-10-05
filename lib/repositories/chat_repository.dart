import 'package:chat_connect/models/models.dart';
import 'package:chat_connect/resources/resources.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';

class ChatRepository {
  const ChatRepository();

  Stream<List<ChatModel>> getChatModelListStream(String uid) {
    try {
      final chatCollection = firebaseFirestore
          .collection('chat')
          .orderBy("lastMessageDate", descending: false)
          .where("users", arrayContains: uid)
          .snapshots();

      return chatCollection.map((querySnapshot) {
        List<ChatModel> chatModelList = [];
        for (var element in querySnapshot.docs) {
          chatModelList.add(ChatModel.fromSnap(element));
        }
        return chatModelList;
      }
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<UserModel>> getReceiverNameList(String id) async {
    try {
      final chatCollection = await firebaseFirestore
          .collection('chat')
          .orderBy("lastMessageDate", descending: false)
          .where("users", arrayContains: firebaseAuth.currentUser!.uid)
          .get();

      final List<Future<UserModel>> receiverModelListFuture =
          chatCollection.docs.map((element) async {
        final model = ChatModel.fromSnap(element);
        return await getReceiverModel(model.users[0], model.users[1]);
      }).toList();

      final List<UserModel> receiverModelList =
          await Future.wait(receiverModelListFuture);

      return receiverModelList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<UserModel> getReceiverModel(String uid1, String uid2) async {
    final DocumentSnapshot<Map<String, dynamic>> uidDoc;
    if (uid1 != firebaseAuth.currentUser!.uid) {
      uidDoc = await firebaseFirestore.collection("user").doc(uid1).get();
    } else {
      uidDoc = await firebaseFirestore.collection("user").doc(uid2).get();
    }
    final data = uidDoc.data();
    return UserModel.fromMap(data!);
  }
}
