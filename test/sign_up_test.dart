import 'package:authentifire/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
// import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  group('SignUp', () {
    test('should sign up user', () async {
      // final mockFirebaseAuth = MockFirebaseAuth();
      // const mockUserData = null;
      // const fakeUid = 'Abcdefghijklmnopqrstuvwxyz';
      // final sut = SignUp(mockFirebaseAuth, mockUserData);
      // // final credential = await mockFirebaseAuth.createUserWithEmailAndPassword(
      // //     email: 'john@example.com', password: '12345678');

      // // final user =
      // //     MockUser(isAnonymous: false, uid: fakeUid, email: 'john@example.com');
      // await sut.signUp(
      //   email: 'john@example.com',
      //   password: '12345678',
      // );

      // expect(
      //     mockFirebaseAuth.createUserWithEmailAndPassword(
      //         email: 'john@example.com', password: '12345678'),
      //     completion(null));
      // Arrange
      final mockFirebaseAuth = MockFirebaseAuth();
      const mockSetUserData = null;
      // final fakeUid = getRandomString(32);
      final sut = SignUp(firebaseAuth: mockFirebaseAuth, setUserData: mockSetUserData);

      // final additionalUserInfo = AdditionalUserInfo(isNewUser: true);
      final user =
          User(uid: 'Abcdefghijklmnopqrstuvwxyz', email: 'john@example.com');
      // final userCredential = UserCredential(
      //     additionalUserInfo: additionalUserInfo, user: mockUser);

      final completer = Completer<UserCredential>();
      completer.complete(UserCredential(
        additionalUSerInfo: AdditionalUserInfo(isNewUser: true),
        user: user,
      ));

      when(mockFirebaseAuth.createUserWithEmailAndPassword(
              email: 'john@example.com', password: '12345678'))
          .thenAnswer((_) => Future.value(user));

      // Act
      await sut.signUp(
        email: 'john@example.com',
        password: '12345678',
      );

      // Assert
    });
  });
}

// String getRandomString(int length) {
//   const chars =
//       'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789';

//   final random = Random();

//   return String.fromCharCodes(Iterable.generate(
//     length,
//     (_) => chars.codeUnitAt(random.nextInt(chars.length)),
//   ));
// }
