import 'package:authentifire/set_user_data.dart';
import 'package:authentifire/sign_up.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SignUp', () {
    test('should sign up user', () async {
      // Arrange
      final mockFirebaseAuth = MockFirebaseAuth();
      final email = 'john@example.com';
      final password = '12345678';
      final sut = SignUp(firebaseAuth: mockFirebaseAuth);

      // Act
      await sut.signUp(email: email, password: password);

      // Assert
      expect(
          mockFirebaseAuth.createUserWithEmailAndPassword(
              email: 'john@example.com', password: '12345678'),
          completion(anything));
    });

    test('should add user data', () async {
      // Arrange
      final mockSetUserData = FakeFirebaseFirestore();
      final userId = 'user123';
      final email = 'john@example.com';
      final username = 'John';
      final phoneNumber = '+123456789';
      final authMethodType = 'email';
      final sut = SetUserData(mockSetUserData);

      // Act
      await sut.setUserData(
          userId: userId,
          email: email,
          username: username,
          phoneNumber: phoneNumber,
          authMethodType: authMethodType);

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
