import 'package:chat_connect/models/models.dart';
import 'package:chat_connect/resources/resources.dart';

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
          userModelList.add(UserModel.fromSnap(element));
        }
      }
      return userModelList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
