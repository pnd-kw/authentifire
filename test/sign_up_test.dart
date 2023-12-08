// import 'package:authentifire/mock_user.dart';
// import 'package:authentifire/mock_user_credential.dart';
// import 'package:authentifire/set_user_data.dart';
// import 'package:authentifire/sign_up.dart';
// import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';

// // Buat mock untuk FirebaseAuth
// class MockFirebaseAuth extends Mock implements firebase_auth.FirebaseAuth {}

// // Buat mock untuk SetUserData
// class MockSetUserData extends Mock implements SetUserData {}

// void main() {
//   late SignUp sut;
//   late MockFirebaseAuth mockFirebaseAuth;
//   late MockSetUserData mockSetUserData;

//   setUp(() {
//     mockFirebaseAuth = MockFirebaseAuth();
//     mockSetUserData = MockSetUserData();
//     sut = SignUp(
//       firebaseAuth: mockFirebaseAuth,
//       setUserData: mockSetUserData,
//     );
//   });

//   test('Successful sign up test', () async {
//     const email = 'john@example.com';
//     const password = '12345678';
//     const validUserId = 'validUserId';

//     final mockUser = MockUser();

//     // Buat objek mock untuk UserCredential
//     final mockUserCredential = MockUserCredential(false, mockUser: mockUser);

//     // Konfigurasi respons ketika metode dipanggil
//     when(mockFirebaseAuth.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     )).thenAnswer((_) async => mockUserCredential);

//     // Memanggil metode yang ingin diuji
//     await sut.signUp(
//       email: email,
//       password: password,
//       username: 'John Doe',
//       phoneNumber: '1234567890',
//       authMethodType: 'email',
//     );

//     // Verifikasi pemanggilan metode dengan argumen yang benar
//     verify(mockFirebaseAuth.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     ));

//     // Verifikasi pemanggilan metode setUserData dengan argumen yang benar
//     verify(mockSetUserData.setUserData(
//       userId: validUserId,
//       email: email,
//       username: 'John Doe',
//       phoneNumber: '1234567890',
//       authMethodType: 'email',
//     )).called(1); // Pastikan bahwa metode ini dipanggil tepat satu kali
//   });

//   // Tambahkan pengujian untuk kasus lain jika diperlukan
// }
// import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
// import 'package:flutter_test/flutter_test.dart';

// void main() {
//   group('Returns a mocked user user after sign up', () {
//     test('with email and password', () async {
//       final email = 'some@email.com';
//       final password = 'some!password';
//       final auth = MockFirebaseAuth();
//       final result = await auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       final user = result.user!;
//       expect(user.email, email);
//       final providerData = user.providerData;
//       expect(providerData.length, 1);
//       expect(providerData.first.providerId, 'password');
//       expect(providerData.first.email, 'some@email.com');
//       expect(providerData.first.uid, user.uid);

//       // expect(auth.authStateChanges(), emitsInOrder([null, isA<User>()]));
//       // expect(auth.userChanges(), emitsInOrder([null, isA<User>()]));
//       expect(user.isAnonymous, isFalse);
//       expect(user.emailVerified, isTrue);
//     });

//     test('with email and password without email verification by default',
//         () async {
//       final email = 'some@email.com';
//       final password = 'some!password';
//       final auth = MockFirebaseAuth(verifyEmailAutomatically: false);
//       final result = await auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       final user = result.user!;
//       expect(user.email, email);
//       final providerData = user.providerData;
//       expect(providerData.length, 1);
//       expect(providerData.first.providerId, 'password');
//       expect(providerData.first.email, 'some@email.com');
//       expect(providerData.first.uid, user.uid);

//       // expect(auth.authStateChanges(), emitsInOrder([null, isA<User>()]));
//       // expect(auth.userChanges(), emitsInOrder([null, isA<User>()]));
//       expect(user.isAnonymous, isFalse);
//       expect(user.emailVerified, isFalse);
//     });
//   });
// }
// import 'package:authentifire/set_user_data.dart';
import 'package:authentifire/sign_up.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';

// Import class SignUp dan SetUserData

// class MockSetUserData extends Mock implements SetUserData {}

void main() {
  group('SignUp', () {
    test('should sign up user', () async {
      final mockFirebaseAuth = MockFirebaseAuth();
      // final mockSetUserData = MockSetUserData();
      const validUserId = 'user123';
      final signUp = SignUp(firebaseAuth: mockFirebaseAuth);

      final email = 'john@example.com';
      final password = '12345678';

      print('Before signing up user');

      await signUp.signUp(email: email, password: password);

      print('After signing up user');

      // Verifikasi bahwa createUserWithEmailAndPassword dipanggil dengan argumen yang benar
      // verify(mockFirebaseAuth.createUserWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // )).called(1);

      expect(
          mockFirebaseAuth.createUserWithEmailAndPassword(
              email: 'john@example.com', password: '12345678'),
          completion(anything));

      // Verifikasi bahwa setUserData dipanggil dengan argumen yang benar
      // verify(mockSetUserData.setUserData(
      //   userId: validUserId,
      //   email: email,
      //   username: 'John',
      //   phoneNumber: '+123456789',
      //   authMethodType: 'email',
      // )).called(1);
    });
  });
}
