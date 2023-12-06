import 'package:authentifire/set_user_data.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SetUserData', () {
    test('should set user data in Firestore', () async {
      // Arrange
      final firestoreMock = FakeFirebaseFirestore();
      final sut = SetUserData(firestoreMock);

      // Create user data
      final userData = getUserData();

      // Act
      // Set user data to Firestore
      await setUser(
        userDataSetter: sut,
        userId: 'user123',
        userData: userData,
        collectionPath: 'users',
      );

      // Assert
      expect(firestoreMock.collection('users').doc('userId').set(userData),
          completion(null));
    });

    test('should set user data with subcollection in Firestore', () async {
      // Arrange
      final firestoreMock = FakeFirebaseFirestore();
      final sut = SetUserData(firestoreMock);
      final userData = getUserData();
      final subCollectionData = getSubCollectionData();

      // Act
      // Set user data to Firestore
      await setUser(
        userDataSetter: sut,
        userId: 'user123',
        userData: userData,
        collectionPath: 'users',
        subCollectionPath: 'linkedAuthMethods',
        authMethodType: 'email',
        isVerified: false,
      );

      // Assert
      expect(firestoreMock.collection('users').doc('user123').set(userData),
          completion(null));
      expect(
          firestoreMock
              .collection('users')
              .doc('user123')
              .collection('linkedAuthMethods')
              .add(subCollectionData),
          completion(anything));
    });
  });
}

// Helper function to create userData
Map<String, dynamic> createUserData({
  String? username,
  String? email,
  String? phoneNumber,
}) {
  return {
    'username': username,
    'email': email,
    'phoneNumber': phoneNumber,
  };
}

Map<String, dynamic> getUserData() {
  final userData = createUserData(
    username: 'John',
    email: 'john@example.com',
    phoneNumber: '+123456789',
  );
  return userData;
}

// Helper function to create subCollectionData
Map<String, dynamic> createSubCollectionData({
  String? authMethodType,
  bool? isVerified,
}) {
  return {
    'authMethodType': authMethodType,
    'isVerified': isVerified,
  };
}

Map<String, dynamic> getSubCollectionData() {
  final subCollectionData =
      createSubCollectionData(authMethodType: 'email', isVerified: false);
  return subCollectionData;
}

// Helper function to set user data to Firestore
Future<void> setUser({
  required SetUserData userDataSetter,
  required String userId,
  required Map<String, dynamic> userData,
  required String collectionPath,
  String? subCollectionPath,
  String? authMethodType,
  bool? isVerified,
}) async {
  await userDataSetter.setUserData(
    userId: userId,
    username: userData['username'],
    email: userData['email'],
    phoneNumber: userData['phoneNumber'],
    collectionPath: collectionPath,
    subCollectionPath: subCollectionPath,
    authMethodType: authMethodType,
    isVerified: false,
  );
}
