import 'package:authentifire/get_linked_auth_method.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:shared_preferences/shared_preferences.dart';

/// Get user verification status which will then be used in Bloc to set the authenticated or unauthenticated user state
class GetUserVerificationStatus {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GetLinkedAuthMethods _getLinkedAuthMethods;
  final SharedPreferences _prefs;

  GetUserVerificationStatus({
    firebase_auth.FirebaseAuth? firebaseAuth,
    GetLinkedAuthMethods? getLinkedAuthMethods,
    required SharedPreferences prefs,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _getLinkedAuthMethods = getLinkedAuthMethods ?? GetLinkedAuthMethods(),
        _prefs = prefs;

  /// Get current auth method via [SharedPreferences]
  /// Get user verification status via [GetLinkedAuthMethods]
  Future<bool?> getUserVerificationStatus() async {
    try {
      // Get user uid
      final userId = _firebaseAuth.currentUser?.uid;
      // Get current auth method
      final currentAuthMethodType = _prefs.getString('authMethod');
      // Get user verification status via [GetLinkedAuthMethods] class
      if (currentAuthMethodType != null) {
        final isVerified = await _getLinkedAuthMethods.getLinkedAuthMethods(
            userId: userId!, authMethodType: currentAuthMethodType);
        return isVerified;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
