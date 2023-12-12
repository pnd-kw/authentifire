import 'package:cloud_firestore/cloud_firestore.dart';

/// Class responsible for setting user data in Firestore
class SetUserData {
  final FirebaseFirestore _firebaseFirestore;

  SetUserData(FirebaseFirestore? firebaseFirestore)
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  /// Sets user data and, optionally, authentication method information in Firestore
  /// [userId] is the unique identifier of the user in Firestore
  /// [username] is the user's username
  /// [email] is the user's email address
  /// [phoneNumber] is the user's phone number
  /// [photoURL] is the URL for the user's photo
  /// [authMethodType] specifies the authentication method
  /// [isVerified] indicates whether the authentication method is verified (default is false)
  /// [subCollectionPath] is the optional subcollection path to store authentication method data
  Future<void> setUserData({
    required String userId,
    required String username,
    required String email,
    required String phoneNumber,
    String? photoURL,
    required String authMethodType,
    required bool isVerified,
  }) async {
    final Map<String, dynamic> userData = {
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'photoURL': photoURL,
    };

    try {
      // Create collection and store user data
      await _firebaseFirestore.collection('users').doc(userId).set(userData);
      // Create subcollection to store authentication method and verification status

      await _firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('linkedAuthMethod')
          .add({
        'authMethodType': authMethodType,
        'isVerified': isVerified,
      });
    } catch (e) {
      throw 'Failed to store user data.';
    }
  }
}
