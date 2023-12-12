class SignInWithPhoneNumberFailure implements Exception {
  final String message;

  const SignInWithPhoneNumberFailure(
      [this.message = 'An unknown exception occured.']);

  factory SignInWithPhoneNumberFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-credential':
        return const SignInWithPhoneNumberFailure(
          'The credential is malformed or has expired.',
        );
      case 'user-disabled':
        return const SignInWithPhoneNumberFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'invalid-verification-code':
        return const SignInWithPhoneNumberFailure(
          'The verification code of the credential is not valid.',
        );
      case 'invalid-verification-id':
        return const SignInWithPhoneNumberFailure(
          'The verification ID of the credential is not valid.id.',
        );
      default:
        return const SignInWithPhoneNumberFailure();
    }
  }
}