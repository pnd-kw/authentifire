import 'package:cloud_firestore/cloud_firestore.dart';

class GetUserData {
  final FirebaseFirestore _firebaseFirestore;

  GetUserData(FirebaseFirestore? firebaseFirestore)
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      // Get user collection data
      final userDoc =
          await _firebaseFirestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        // Type Casting DocumentSnapshot<Map<String, dynamic>> to Map<String, dynamic>? to access data
        final userData = userDoc.data() as Map<String, dynamic>;
        // Get user subcollection reference
        final linkedAuthMethodsCollection =
            userDoc.reference.collection('linkedAuthMethods');
        // Get user subcollection data
        final linkedAuthMethodsDocs = await linkedAuthMethodsCollection.get();
        // Get data as List<Map<String, dynamic>>
        final linkedAuthMethodsData =
            linkedAuthMethodsDocs.docs.map((doc) => doc.data()).toList();
        // Assign data to linkedAuthMethods subcollection Type Map<String, dynamic>? and merge it to user collection data
        userData['linkedAuthMethods'] = linkedAuthMethodsData;

        return userData;
      } else {
        return null;
      }
    } catch (e) {
      throw 'Failed to get user data.';
    }
  }
}
