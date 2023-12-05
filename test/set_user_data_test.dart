import 'package:authentifire/set_user_data.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SetUserData', () {
    test('should set user data in Firestore', () async {
      // Arrange
      final firestoreMock = FakeFirebaseFirestore();
      final sut = SetUserData(firestoreMock);
      final userData = {
        'username': 'John',
        'email': 'john@example.com',
        'phoneNumber': '+123456789',
      };

      // Act
      await sut.setUserData(
        userId: 'user123',
        username: 'John',
        email: 'john@example.com',
        phoneNumber: '+123456789',
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
      final userData = {
        'username': 'John',
        'email': 'john@example.com',
        'phoneNumber': '+123456789',
      };
      final subCollectionData = {
        'authMethodType': 'email',
        'isVerified': false,
      };

      // Act
      await sut.setUserData(
        userId: 'user123',
        username: 'John',
        email: 'john@example.com',
        phoneNumber: '+123456789',
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
