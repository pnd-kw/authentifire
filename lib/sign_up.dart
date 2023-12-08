import 'package:authentifire/set_user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

class SignUp {
  final MockFirebaseAuth _firebaseAuth; // Only used for testing needs

  // final firebase_auth.FirebaseAuth _firebaseAuth;
  // final SetUserData _setUserData;

  SignUp({
    MockFirebaseAuth? firebaseAuth, // Only used for testing needs
    // firebase_auth.FirebaseAuth? firebaseAuth,
    // SetUserData? setUserData,
  }) : _firebaseAuth =
            firebaseAuth ?? MockFirebaseAuth(); // Only used for testing needs
  // _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
  // _setUserData = setUserData ?? SetUserData(FirebaseFirestore.instance);

  Future<void> signUp({
    required String email,
    required String password,
    String? username,
    String? phoneNumber,
    String? authMethodType,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      // final userId = _firebaseAuth.currentUser?.uid;

      // await _setUserData.setUserData(
      //   userId: userId!,
      //   email: email,
      //   username: username,
      //   phoneNumber: phoneNumber,
      //   authMethodType: 'email',
      // );
    } catch (e) {
      print('Exception occurred during sign up: $e');
      throw 'Failed to sign up.';
    }
  }
}
