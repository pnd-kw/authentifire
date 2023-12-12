import 'package:cloud_firestore/cloud_firestore.dart';

/// Class responsible for retrieving linked authentication methods from Firestore
class GetLinkedAuthMethods {
  final FirebaseFirestore _firebaseFirestore;

  GetLinkedAuthMethods({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  /// Retrieves the verification status of a specific authentication method for a user
  /// 
  /// [userId] is the unique identifier of the user in Firestore
  /// [authMethodType] specifies the type of authentication method to retrieve
  /// 
  /// Returns a boolean indicating the verification status, or null if not available
  Future<bool?> getLinkedAuthMethods({
    required String userId,
    required String authMethodType,
  }) async {
    try {
      // Access collection and subcollection
      final userRef = _firebaseFirestore.collection('users').doc(userId);
      final linkedAuthMethodsCollection =
          userRef.collection('linkedAuthMethods');
      // Get authMethodType in subcollection field match with given parameter
      final querySnapshot = await linkedAuthMethodsCollection
          .where('authMethodType', isEqualTo: authMethodType)
          .get();
      // Return verification based on authMethodType
      if (querySnapshot.docs.isNotEmpty) {
        final docSnapshot = querySnapshot.docs.first;
        final data = docSnapshot.data();
        final isVerified = data['isVerified'] as bool;
        return isVerified;
      } else {
        return null;
      }
    } catch (e) {
      throw 'Failed to get LinkedAuthMethod';
    }
  }
}
