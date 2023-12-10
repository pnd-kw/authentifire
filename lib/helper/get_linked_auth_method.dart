import 'package:cloud_firestore/cloud_firestore.dart';

class GetLinkedAuthMethods {
  final FirebaseFirestore _firebaseFirestore;

  GetLinkedAuthMethods({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

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
