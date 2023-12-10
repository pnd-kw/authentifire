class UserDocumentNotFound implements Exception {
  final String message;

  const UserDocumentNotFound([
    this.message = 'User document not found.',
  ]);
}
