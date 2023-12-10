import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:authentifire/get_linked_auth_method.dart';

/// Get GoogleSignIn verification status in authMethodType which has value of 'google' via [GetLinkedAuthMethods]

class GetGoogleSignInStatus {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GetLinkedAuthMethods _getLinkedAuthMethods;

  GetGoogleSignInStatus({
    firebase_auth.FirebaseAuth? firebaseAuth,
    GetLinkedAuthMethods? getLinkedAuthMethods,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _getLinkedAuthMethods = getLinkedAuthMethods ?? GetLinkedAuthMethods();

  Future<bool?> getGoogleSignInStatus(String userId) async {
    final userId = _firebaseAuth.currentUser?.uid;

    final isVerified = await _getLinkedAuthMethods.getLinkedAuthMethods(
        userId: userId!, authMethodType: 'google');

    return isVerified;
  }
}
