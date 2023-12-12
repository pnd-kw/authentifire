import 'package:authentifire/helper/set_user_data.dart';
import 'package:authentifire/auth/sign_up.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SignUp', () {
    test('should sign up user', () async {
      // Arrange
      final mockFirebaseAuth = MockFirebaseAuth();
      const email = 'john@example.com';
      const password = '12345678';
      const username = 'John';
      const phoneNumber = '+123456789';
      const authMethodType = 'email';
      final sut = SignUp(firebaseAuth: mockFirebaseAuth);

      // Act
      await sut.signUp(
          email: email,
          password: password,
          username: username,
          phoneNumber: phoneNumber,
          authMethodType: authMethodType,
          isVerified: false);

      // Assert
      expect(
          mockFirebaseAuth.createUserWithEmailAndPassword(
              email: 'john@example.com', password: '12345678'),
          completion(anything));
    });

    test('should add user data', () async {
      // Arrange
      final mockSetUserData = FakeFirebaseFirestore();
      const userId = 'user123';
      const email = 'john@example.com';
      const username = 'John';
      const phoneNumber = '+123456789';
      const authMethodType = 'email';
      final sut = SetUserData(mockSetUserData);

      // Act
      await sut.setUserData(
        userId: userId,
        email: email,
        username: username,
        phoneNumber: phoneNumber,
        authMethodType: authMethodType,
        isVerified: false,
      );

      // Assert
      expect(
          mockSetUserData.collection('users').doc(userId).set({
            'email': email,
            'username': username,
            'phoneNumber': phoneNumber,
            'authMethodType': authMethodType,
          }),
          completion(anything));
    });
  });
}
