import 'package:authentifire/helper/set_user_data.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart'; // Only used for testing needs
import 'package:authentifire/exception/sign_up_exception.dart';

// abstract class SignUpRepository {
//   Future<void> signUp({
//     required String email,
//     required String password,
//     String? username,
//     String? phoneNumber,
//     String? photoURL,
//     String? authMethodType,
//   });
// }

/// Class responsible for handling user sign-up functionality
class SignUp {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final SetUserData _setUserData;

  SignUp({
    firebase_auth.FirebaseAuth? firebaseAuth,
    SetUserData? setUserData,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        // _setUserData = setUserData ?? SetUserData(FirebaseFirestore.instance);
        _setUserData = setUserData ??
            SetUserData(FakeFirebaseFirestore()); // Only used for testing needs

  /// Signs up a new user with the provided email and password
  ///
  /// [email] is the email address of the user
  /// [password] is the password for the new account
  /// [username] is an optional parameter for the user's username
  /// [phoneNumber] is an optional parameter for the user's phone number
  /// [photoURL] is an optional parameter for the user's photo url
  /// [authMethodType] specifies the authentication method used (default is 'email)
  ///
  /// Throws a [SignUpWithEmailAndPasswordFailure] if the sign-up process fails
  Future<void> signUp({
    required String email,
    required String password,
    required String username,
    required String phoneNumber,
    String? photoURL,
    required String authMethodType,
    required bool isVerified,
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
        photoURL: photoURL,
        authMethodType: authMethodType,
        isVerified: isVerified,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }
}
