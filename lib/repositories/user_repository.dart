import 'package:chat_connect/models/models.dart';
import 'package:chat_connect/resources/resources.dart';

class UserRepository {
  const UserRepository();

  Stream<UserModel> getUserStream(String uid) {
    return firebaseFirestore
        .collection('user')
        .doc(uid)
        .snapshots()
        .map((snapshot) => UserModel.fromSnap(snapshot));
  }

  Future<void> updateUser(UserModel userModel) async {
    await firebaseFirestore
        .collection('user')
        .doc(firebaseAuth.currentUser!.uid)
        .update({
      'firstName': userModel.firstName,
      'lastName': userModel.lastName,
      'email': userModel.email,
      'photoUrl': userModel.photoUrl
    });
  }
}
