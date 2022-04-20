class UnknownException implements Exception {
  UnknownException({
    this.errorMessage = 'Unknown Error',
  });

  final String errorMessage;
}
