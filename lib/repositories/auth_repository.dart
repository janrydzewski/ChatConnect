import 'package:firebase_auth/firebase_auth.dart';

import 'package:chat_connect/models/models.dart';
import 'package:chat_connect/resources/resources.dart';

class AuthRepository {
  Future<void> signUp(
      {required String firstName,
      required String lastName,
      required String email,
      required String password}) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception();
    }
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      UserModel userModel = UserModel(
        id: firebaseAuth.currentUser!.uid,
        firstName: firstName,
        lastName: lastName,
        email: email,
      );

      await firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser?.uid)
          .set(userModel.toMap());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw Exception("Email already in use");
      }

      if (e.code == 'invalid-email') {
        throw Exception("Invalid email");
      }
      if (e.code == 'weak-password') {
        throw Exception("Weak password");
      }
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception();
    }
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception("User not found");
      }
      if (e.code == 'invalid-email') {
        throw Exception("Invalid email");
      }
      if (e.code == 'wrong-password') {
        throw Exception("Wrong password");
      }
    }
  }

  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
