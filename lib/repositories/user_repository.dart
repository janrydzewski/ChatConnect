import 'package:chat_connect/models/models.dart';
import 'package:chat_connect/resources/resources.dart';

class UserRepository{
  const UserRepository();

  Stream<UserModel> getUserStream(String uid) {
    return firebaseFirestore
        .collection('user')
        .doc(uid)
        .snapshots()
        .map((snapshot) => UserModel.fromSnap(snapshot));
  }

  // Stream<UserModel> getUserStream(String uid) {
  //   return firebaseFirestore
  //       .collection('users')
  //       .doc(uid)
  //       .snapshots()
  //       .map((snapshot) => UserModel.fromSnap(snapshot));
  // }

  // Future<void> updateUser(UserModel userModel) async {
  //   await firebaseFirestore
  //       .collection('users')
  //       .doc(firebaseAuth.currentUser!.uid)
  //       .update({
  //     'fullName': userModel.fullName,
  //     'userName': userModel.userName,
  //     'birthDate': userModel.birthDate,
  //     'email': userModel.email,
  //     'phoneNumber': userModel.phoneNumber,
  //     'gender': userModel.gender,
  //     'profilePhoto': userModel.profilePhoto,
  //     'country': userModel.country,
  //   });
  // }
}