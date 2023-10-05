import 'package:chat_connect/models/models.dart';
import 'package:chat_connect/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchUserRepository {
  const SearchUserRepository();

  Future<List<UserModel>> getUserModelList(String searchingText) async {
    List<UserModel> userModelList = [];

    try {
      final userCollection = await firebaseFirestore.collection("user").get();
      for (var element in userCollection.docs) {
        final userModel = UserModel.fromSnap(element);
        if ("${userModel.firstName.toLowerCase()} ${userModel.lastName.toLowerCase()}"
            .contains(searchingText.toLowerCase())) {
          if (userModel.id != firebaseAuth.currentUser!.uid) {
            userModelList.add(UserModel.fromSnap(element));
          }
        }
      }
      return userModelList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> isAlreadyUsersHaveRoom(
      UserModel userModel, BuildContext context) async {
    final chatCollection = await firebaseFirestore.collection("chat").get();
    for (var element in chatCollection.docs) {
      final chatModel = ChatModel.fromSnap(element);
      if (chatModel.users.contains(firebaseAuth.currentUser!.uid) &&
          chatModel.users.contains(userModel.id)) {
        // ignore: use_build_context_synchronously
        context.go("/message", extra: {
          "chatRoomId": chatModel.id,
          "receiverName": "${userModel.firstName} ${userModel.lastName}"
        });
        return;
      }
    }
    final roomId = await createRoom(userModel.id);
    // ignore: use_build_context_synchronously
    context.go("/message", extra: {
      "chatRoomId": roomId,
      "receiverName": "${userModel.firstName} ${userModel.lastName}"
    });
    return;
  }

  Future<String> createRoom(String uid1) async {
    final chatModel = ChatModel(
        id: "",
        users: [firebaseAuth.currentUser!.uid, uid1],
        lastSender: "",
        lastMessage: "",
        lastMessageDate: DateTime.now());
    final documentRef =
        await firebaseFirestore.collection("chat").add(chatModel.toMap());
    await firebaseFirestore
        .collection("chat")
        .doc(documentRef.id)
        .update({"id": documentRef.id});
    return documentRef.id;
  }
}
