import 'package:authentifire/set_user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

class SignUp {
  // final MockFirebaseAuth _firebaseAuth;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final SetUserData _setUserData;

  SignUp({
    // MockFirebaseAuth? firebaseAuth,
    firebase_auth.FirebaseAuth? firebaseAuth,
    SetUserData? setUserData,
  })  :
        // _firebaseAuth = firebaseAuth ?? MockFirebaseAuth();
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _setUserData = setUserData ?? SetUserData(FakeFirebaseFirestore());

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

      final userId = _firebaseAuth.currentUser?.uid;

      await _setUserData.setUserData(
        userId: userId!,
        email: email,
        username: username,
        phoneNumber: phoneNumber,
        authMethodType: 'email',
      );
    } catch (e) {
      print('Exception occurred during sign up: $e');
      throw 'Failed to sign up.';
    }
  }
}
