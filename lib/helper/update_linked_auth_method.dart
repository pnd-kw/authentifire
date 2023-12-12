import 'package:cloud_firestore/cloud_firestore.dart';

/// Class responsible for updating linked authentication methods in Firestore
class UpdateLinkedAuthMethod {
  final FirebaseFirestore _firebaseFirestore;

  UpdateLinkedAuthMethod({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  /// Updates the linked authentication method for a specific user
  /// 
  /// [userId] identifies the user in Firestore
  /// [authMethodType] specifies the type of authentication method to be updated
  /// [updateData] is a Map containing the data to be updated
  /// 
  /// Throws an error if the update process fails
  Future<void> updateLinkedAuthMethod(String userId, String authMethodType,
      Map<String, dynamic> updateData) async {
    try {
      final userRef = _firebaseFirestore.collection('users').doc(userId);
      final linkedAuthMethodsCollection =
          userRef.collection('linkedAuthMethods');

      final querySnapshot = await linkedAuthMethodsCollection
          .where('authMethodType', isEqualTo: authMethodType)
          .get();

      for (final doc in querySnapshot.docs) {
        await doc.reference.update(updateData);
      }
    } catch (e) {
      throw 'Failed to update linkedAuthMethod.';
    }
  }
}
