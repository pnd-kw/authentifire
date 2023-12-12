import 'package:authentifire/exception/reset_password_exception.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

/// Class responsible for handling password reset functionality
class Resetpassword {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  Resetpassword({
    firebase_auth.FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;
  /// Sends a password reset email to the specified email address
  /// 
  /// [email] is the email address for which the password reset email is sent
  /// 
  /// Throws a [ResetPasswordFailure] if the password reset email sending process fails
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw const ResetPasswordFailure();
    }
  }
}
