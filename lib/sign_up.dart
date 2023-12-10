import 'package:authentifire/set_user_data.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fake_cloud_firestore/fake_cloud_firestore.dart'; // Only used for testing needs
import 'package:authentifire/sign_up_exception.dart';

class SignUp {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final SetUserData _setUserData;

  SignUp({
    firebase_auth.FirebaseAuth? firebaseAuth,
    SetUserData? setUserData,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _setUserData = setUserData ?? SetUserData(FirebaseFirestore.instance);
  // _setUserData = setUserData ??
  //     SetUserData(FakeFirebaseFirestore()); // Only used for testing needs

  Future<void> signUp({
    required String email,
    required String password,
    String? username,
    String? phoneNumber,
    String? authMethodType,
  }) async {
    try {
      // Sign up new user
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      final userId = _firebaseAuth.currentUser?.uid;
      // Set user data to firestore
      await _setUserData.setUserData(
        userId: userId!,
        email: email,
        username: username,
        phoneNumber: phoneNumber,
        authMethodType: 'email',
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }
}
