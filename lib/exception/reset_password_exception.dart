class ResetPasswordFailure implements Exception {
  final String message;

  const ResetPasswordFailure([this.message = 'An unknown exception occured.']);

  factory ResetPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const ResetPasswordFailure(
          'Email address is not valid.',
        );
      case 'missing-android-pkg-name':
        return const ResetPasswordFailure(
          'An Android package name must be provided if the Android app is required to be installed.',
        );
      case 'missing-continue-uri':
        return const ResetPasswordFailure(
          'A continue URL must be provided in the request.',
        );
      case 'missing-ios-bundle-id':
        return const ResetPasswordFailure(
          'An iOS Bundle ID must be provided if an App Store ID is provided.',
        );
      case 'invalid-continue-uri':
        return const ResetPasswordFailure(
          'The Continue URL provided in the request is invalid.',
        );
      case 'unauthorized-continue-uri':
        return const ResetPasswordFailure(
          'The domain of the continue URL is not whitelisted. Whitelist the domain in the Firebase console.',
        );
      case 'user-not-found':
        return const ResetPasswordFailure(
          'There is no user corresponding to the email address.',
        );
      default:
        return const ResetPasswordFailure();
    }
  }
}