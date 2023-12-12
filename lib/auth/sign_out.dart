import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

/// Class responsible for signing the user out of Firebase Authentication
class SignOut {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  SignOut({
    firebase_auth.FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;
  /// Signs the user out of Firebase Authentication
  ///
  /// Throws an exception if the sign-out process fails
  Future<void> signOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
      ]);
    } catch (e) {
      throw Exception(e);
    }
  }
}
