import 'package:authentifire/set_user_data.dart';
import 'package:authentifire/sign_up.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Import class SignUp dan SetUserData

class MockSetUserData extends Mock implements SetUserData {}

void main() {
  group('SignUp', () {
    test('should sign up user', () async {
      // Arrange
      final mockFirebaseAuth = MockFirebaseAuth();
      const validUserId = 'user123';
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
      final mockSetUserData = MockSetUserData();
      final userId = 'user123';
      final email = 'john@example.com';
      final username = 'John';
      final phoneNumber = '+123456789';
      final authMethodType = 'email';
      final sut = SignUp(set)
    });
  });
}
