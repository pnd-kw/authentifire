class SignInFailure implements Exception {
  final String message;

  const SignInFailure([
    this.message = 'An unknown exception occured.',
  ]);

  factory SignInFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignInFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignInFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const SignInFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const SignInFailure(
          'Incorrect password, please try again.',
        );
      default:
        return const SignInFailure();
    }
  }
}
