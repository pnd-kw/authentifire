import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class SignUp {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  SignUp(
    firebase_auth.FirebaseAuth? firebaseAuth,
  ) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  Future<void> signUp() async {}
}
