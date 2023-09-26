import 'package:chat_connect/models/models.dart';
import 'package:chat_connect/resources/resources.dart';

class ChatRepository {
  const ChatRepository();

  Future<List<ChatModel>> getChatModelList(String uid) async {
    List<ChatModel> chatModelList = [];

    try {
      final chatCollection = await firebaseFirestore.collection('chat').get();
      chatCollection.docs.forEach((element) {
        chatModelList.add(ChatModel.fromSnap(element));
      });
      return chatModelList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
