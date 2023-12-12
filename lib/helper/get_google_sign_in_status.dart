import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:authentifire/helper/get_linked_auth_method.dart';

/// Class responsible for retrieves the GoogleSignIn verification status from the authMethodType 'google' using [GetLinkedAuthMethods]

class GetGoogleSignInStatus {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GetLinkedAuthMethods _getLinkedAuthMethods;

  GetGoogleSignInStatus({
    firebase_auth.FirebaseAuth? firebaseAuth,
    GetLinkedAuthMethods? getLinkedAuthMethods,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _getLinkedAuthMethods = getLinkedAuthMethods ?? GetLinkedAuthMethods();

  /// Retrieves the verification status of GoogleSignIn in the 'google' authMethodType
  ///
  /// [userId] is the unique identifier of the user
  ///
  /// Returns a boolean indicating the verification status, or null if not available
  Future<bool?> getGoogleSignInStatus(String? userId) async {
    final userId = _firebaseAuth.currentUser?.uid;

    final isVerified = await _getLinkedAuthMethods.getLinkedAuthMethods(
        userId: userId!, authMethodType: 'google');

    return isVerified;
  }
}
