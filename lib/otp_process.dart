import 'package:authentifire/get_user_data.dart';
import 'package:authentifire/sign_in_exception.dart';
import 'package:authentifire/user_document_not_found_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class RequestOtp {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  GetUserData _getUserData;

  RequestOtp({
    firebase_auth.FirebaseAuth? firebaseAuth,
    GetUserData? getUserData,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _getUserData = getUserData ?? GetUserData(FirebaseFirestore.instance);

  /// Requests OTP verification
  /// Retrieves user data using [GetUserData] and verifies phone number through OTP
  Future<void> requestOtp() async {
    String? _verificationId;
    try {
      // Retrieving the current user's ID from Firebase Authentication
      final userId = _firebaseAuth.currentUser?.uid;
      if (userId != null) {
        // Fetching user document data from FireStore using the provided [GetUserData]
        final userDoc = await _getUserData.getUserData(userId);
        if (userDoc != null) {
          // Extracting user's phone number from the user document
          final userPhoneNumber = userDoc['phoneNumber'];

          // Verifying phone number using OTP verification from Firebase Authentication
          await _firebaseAuth.verifyPhoneNumber(
            phoneNumber: userPhoneNumber,
            verificationCompleted:
                (firebase_auth.PhoneAuthCredential credential) {},
            verificationFailed: (firebase_auth.FirebaseAuthException e) {},
            codeSent: (String verificationId, int? resendToken) {
              _verificationId = verificationId;
            },
            codeAutoRetrievalTimeout: (String verificationId) {},
          );
        }
      } else {
        throw const UserDocumentNotFound();
      }
    } catch (e) {
      throw const SignInFailure();
    }
  }
}
