import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:shared_preferences/shared_preferences.dart';
import 'model/user.dart';

/// This class manages Shared Preferences and Firebase Authentication settings
class SharedPreferencesSetting {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final SharedPreferences _prefs;

  SharedPreferencesSetting({
    firebase_auth.FirebaseAuth? firebaseAuth,
    required SharedPreferences prefs,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _prefs = prefs;
  // Getter to fetch the current user from Firebase Authentication and Shared Preferences
  User get currentUser {
    final user = _firebaseAuth.currentUser?.toUser ?? User.empty;
    final isLoggedIn = _prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      return user;
    } else {
      return User.empty;
    }
  }

  // Returns a stream that monitors changes in the user's authentication status
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      _prefs.setBool('isLoggedIn', firebaseUser != null);
      return user;
    });
  }
}

// Extension method to convert Firebase User object to a local User object
extension on firebase_auth.User {
  User get toUser {
    return User(
        id: uid,
        username: displayName,
        email: email,
        phoneNumber: phoneNumber,
        photoURL: photoURL);
  }
}
