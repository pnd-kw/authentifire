import 'package:authentifire/helper/add_linked_auth_method.dart';
// import 'package:authentifire/helper/get_google_sign_in_status.dart';
import 'package:authentifire/helper/get_linked_auth_method.dart';
import 'package:authentifire/helper/set_user_data.dart';
import 'package:authentifire/exception/sign_in_with_google_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Class responsible for handling Google Sign-In and linking with Firebase Authentication
class SignInWithGoogle {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  // final GetGoogleSignInStatus _getGoogleSignInStatus;
  final GetLinkedAuthMethods _getLinkedAuthMethods;
  final SetUserData _setUserData;
  final AddLinkedAuthMethod _addLinkedAuthMethod;
  final SharedPreferences _prefs;
  String _existingEmail = '';

  SignInWithGoogle({
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
    // GetGoogleSignInStatus? getGoogleSignInStatus,
    GetLinkedAuthMethods? getLinkedAuthMethods,
    SetUserData? setUserData,
    AddLinkedAuthMethod? addLinkedAuthMethod,
    required SharedPreferences prefs,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn(),
        // _getGoogleSignInStatus =
        //     getGoogleSignInStatus ?? GetGoogleSignInStatus(),
        _getLinkedAuthMethods = getLinkedAuthMethods ?? GetLinkedAuthMethods(),
        _setUserData = setUserData ?? SetUserData(FirebaseFirestore.instance),
        _addLinkedAuthMethod = addLinkedAuthMethod ?? AddLinkedAuthMethod(),
        _prefs = prefs;

  /// Signs in the user using Google Sign-In
  ///
  /// Fetches the user's information from Google and performs sign-in or user creation based on whether the email already exists in Firebase Authentication
  ///
  /// Returns the existing email if the user signs in successfully, otherwise throws a [SignInWithGoogleFailure]
  Future<String> signInWithGoogle() async {
    try {
      final userId = _firebaseAuth.currentUser?.uid;
      late final firebase_auth.AuthCredential googleCredential;
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      googleCredential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final email = googleUser.email;

      final existingUser =
          await _firebaseAuth.fetchSignInMethodsForEmail(email);

      if (existingUser.isNotEmpty) {
        _existingEmail = email;
        await _firebaseAuth.signInWithCredential(googleCredential);
        getGoogleSignInStatus();
        await _prefs.setString('authMethod', 'google');
      } else {
        await _firebaseAuth.signInWithCredential(googleCredential);
        await _setUserData.setUserData(
          userId: userId!,
          username: googleUser.displayName!,
          email: email,
          phoneNumber: '-',
          authMethodType: 'google',
          isVerified: true,
        );
      }
      return _existingEmail;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignInWithGoogleFailure.fromCode(e.code);
    } catch (_) {
      throw const SignInWithGoogleFailure();
    }
  }

  /// Links an existing Firebase account with a Google account
  ///
  /// Signs in with Google, then links the Google account with the existing Firebase account using credentials
  ///
  /// [password] is required to authenticate the existing email user
  /// Throws an exception if the linking process fails
  Future<void> linkGoogleWithExistingEmail(String password) async {
    try {
      final emailCredential = await signInWithGoogle();

      if (emailCredential.isNotEmpty) {
        await _firebaseAuth.signInWithEmailAndPassword(
            email: _existingEmail, password: password);
      }
      late final firebase_auth.AuthCredential googleCredential;
      final user = _firebaseAuth.currentUser;
      final userId = _firebaseAuth.currentUser?.uid;
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      googleCredential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      if (user != null) {
        user.linkWithCredential(googleCredential);
        await _addLinkedAuthMethod.addLinkedAuthMethod(userId!, 'google', true);
        await _prefs.setString('authMethod', 'google');
      }
    } catch (e) {
      throw Exception();
    }
  }

  Future<bool?> getGoogleSignInStatus() async {
    final userId = _firebaseAuth.currentUser?.uid;

    final isVerified = await _getLinkedAuthMethods.getLinkedAuthMethods(
        userId: userId!, authMethodType: 'google');

    return isVerified;
  }
}
