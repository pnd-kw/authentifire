import 'package:authentifire/mock_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MockUserCredential implements UserCredential {
  final MockUser _mockUser;

  MockUserCredential(bool isAnonymous, {MockUser? mockUser})
      // Ensure no mocked credentials or mocked for Anonymous
      : assert(mockUser == null || mockUser.isAnonymous == isAnonymous),
        _mockUser = mockUser ?? MockUser(isAnonymous: isAnonymous);

  @override
  User get user => mockUser;

  // Strongly typed for use within the project.
  MockUser get mockUser => _mockUser;

  @override
  // todo implement additionalUserInfo
  AdditionalUserInfo? get additionalUserInfo => throw UnimplementedError();

  @override
  // todo implement credential
  AuthCredential? get credential => throw UnimplementedError();
}
