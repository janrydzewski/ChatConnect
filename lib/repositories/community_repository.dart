import 'package:chat_connect/models/models.dart';
import 'package:chat_connect/resources/resources.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommunityRepository {
  const CommunityRepository();

  Future<List<PostModel>> getPostsList() async {
    List<PostModel> postModelList = [];

    try {
      final postCollection = await firebaseFirestore
          .collection("post")
          .orderBy("date", descending: false)
          .get();
      for (var element in postCollection.docs) {
        postModelList.add(PostModel.fromSnap(element));
      }
      return postModelList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> createPost(PostModel postModel) async {
    try {
      final documentRef =
          await firebaseFirestore.collection("post").add(postModel.toMap());

      await firebaseFirestore
          .collection("post")
          .doc(documentRef.id)
          .update({"id": documentRef.id});
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<UserModel>> getAuthorIdList() async {
    try {
      final postCollection = await firebaseFirestore
          .collection('post')
          .orderBy("date", descending: false)
          .get();

      final List<Future<UserModel>> authorIdListFuture =
          postCollection.docs.map((element) async {
        final model = PostModel.fromSnap(element);
        return await getAuthorModel(model.authorId);
      }).toList();

      final List<UserModel> authorIdList =
          await Future.wait(authorIdListFuture);

      return authorIdList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<UserModel> getAuthorModel(String uid1) async {
    final DocumentSnapshot<Map<String, dynamic>> uidDoc =
        await firebaseFirestore.collection("user").doc(uid1).get();
    final data = uidDoc.data();
    return UserModel.fromMap(data!);
  }
}
