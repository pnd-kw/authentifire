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
    required String collectionPath,
    String? subCollectionPath,
  }) async {
    final Map<String, dynamic> userData = {
      if (username != null) 'username': username,
      if (email != null) 'email': email,
      if (phoneNumber != null) 'phoneNumber': phoneNumber,
    };

    try {
      await _firebaseFirestore
          .collection(collectionPath)
          .doc(userId)
          .set(userData);

      if (subCollectionPath != null) {
        await _firebaseFirestore
            .collection(collectionPath)
            .doc(userId)
            .collection(subCollectionPath)
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
