import 'package:cloud_firestore/cloud_firestore.dart';

class SetUserData {
  final FirebaseFirestore _firebaseFirestore;

  SetUserData(FirebaseFirestore? firebaseFirestore)
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<void> setUserData({
    required String userId,
    String? username,
    String? email,
    String? phoneNumber,
    String? authMethodType,
    bool isVerified = false,
    String? subCollectionPath,
  }) async {
    final Map<String, dynamic> userData = {
      if (username != null) 'username': username,
      if (email != null) 'email': email,
      if (phoneNumber != null) 'phoneNumber': phoneNumber,
    };

    try {
      // Create collection and store user data
      await _firebaseFirestore.collection('users').doc(userId).set(userData);
      // Create subcollection to store authentication method and verification status
      if (subCollectionPath != null) {
        await _firebaseFirestore
            .collection('users')
            .doc(userId)
            .collection('linkedAuthMethod')
            .add({
          'authMethodType': authMethodType,
          'isVerified': isVerified,
        });
      }
    } catch (e) {
      throw 'Failed to store user data.';
    }
  }
}
