// Untuk mendapatkan status verifikasi user yang kemudian akan digunakan pada Bloc untuk mengatur state user authenticated atau unauthenticated

import 'package:authentifire/get_linked_auth_method.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<bool?> getUserVerificationStatus() async {
    try {
      final userId = _firebaseAuth.currentUser?.uid;

      final currentAuthMethodType = _prefs.getString('authMethod');

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
