import 'package:cloud_firestore/cloud_firestore.dart';

/// Class responsible for adding a linked authentication method to Firestore
class AddLinkedAuthMethod {
  final FirebaseFirestore _firebaseFirestore;

  AddLinkedAuthMethod({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  /// Adds a linked authentication method to a user's document in Firestore
  /// 
  /// [userId] identifies the user in Firestore
  /// [authMethodType] specifies the type of authentication method to be added
  /// [isVerified] indicates whether the added authentication method is verified or not
  /// 
  /// Throws an error if the addition process fails
  Future<void> addLinkedAuthMethod(
      String userId, String authMethodType, bool isVerified) async {
    try {
      final userRef = _firebaseFirestore.collection('users').doc(userId);
      final linkedAuthMethodsCollection =
          userRef.collection('linkedAuthMethods');

      // Adding data for the linked authentication method to Firestore
      await linkedAuthMethodsCollection.add({
        'authMethodType': authMethodType,
        'isVerified': isVerified,
      });
    } catch (e) {
      throw 'Failed to add linkedAuthMethods data.';
    }
  }
}
