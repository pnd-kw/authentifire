import 'package:authentifire/helper/get_user_data.dart';
import 'package:authentifire/exception/sign_in_exception.dart';
import 'package:authentifire/exception/sign_in_with_phone_number_exception.dart';
import 'package:authentifire/helper/update_linked_auth_method.dart';
import 'package:authentifire/exception/user_document_not_found_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

/// Class responsible for phone number verification
class OtpProcess {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GetUserData _getUserData;
  final UpdateLinkedAuthMethod _updateLinkedAuthMethod;
  String? _verificationId;

  OtpProcess({
    firebase_auth.FirebaseAuth? firebaseAuth,
    GetUserData? getUserData,
    UpdateLinkedAuthMethod? updateLinkedAuthMethod,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _getUserData = getUserData ?? GetUserData(FirebaseFirestore.instance),
        _updateLinkedAuthMethod =
            updateLinkedAuthMethod ?? UpdateLinkedAuthMethod();
  /// Requests OTP verification
  /// Retrieves user data using [GetUserData] and verifies phone number through OTP
  Future<void> requestOtp() async {
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
  /// Verifies the OTP code provided by the user
  /// 
  /// [code] is the OTP code to be verified
  /// 
  /// If the OTP verification is successful, the method links the user's phone number with their email as a verified authentication method in Firebase Authentication using [UpdateLinkedAuthMethod]
  ///
  /// Returns 'true' if the OTP verification and linking process is successful
  /// Throws a [SignInWithPhoneNumberFailure] if the verification or linking fails
  Future<bool> verifyOtp(String code) async {
    try {
      final user = _firebaseAuth.currentUser;
      final userId = _firebaseAuth.currentUser?.uid;

      if (_verificationId != null) {
        final credential = firebase_auth.PhoneAuthProvider.credential(
            verificationId: _verificationId!, smsCode: code);
        if (user != null) {
          await user.linkWithCredential(credential);

          await _updateLinkedAuthMethod
              .updateLinkedAuthMethod(userId!, 'email', {'isVerified': true});
        }
        return true;
      } else {
        throw const SignInWithPhoneNumberFailure();
      }
    } catch (e) {
      throw const SignInWithPhoneNumberFailure();
    }
  }
}
