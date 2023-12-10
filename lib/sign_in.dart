import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:authentifire/get_linked_auth_method.dart';
import 'package:authentifire/sign_in_exception.dart';

class SignIn {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GetLinkedAuthMethods _getLinkedAuthMethods;

  SignIn({
    firebase_auth.FirebaseAuth? firebaseAuth,
    GetLinkedAuthMethods? getLinkedAuthMethods,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _getLinkedAuthMethods = getLinkedAuthMethods ?? GetLinkedAuthMethods();

  /// Sign in user and check user verification status via [GetLinkedAuthMethods]
  Future<bool?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // Sign in user
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      // Get current user uid
      final userId = _firebaseAuth.currentUser?.uid;
      // Checking user verification status via [GetLinkedAuthMethods] class
      final isVerified = _getLinkedAuthMethods.getLinkedAuthMethods(
          userId: userId!, authMethodType: 'email');

      return isVerified;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignInFailure.fromCode(e.code);
    } catch (_) {
      throw const SignInFailure();
    }
  }
}
