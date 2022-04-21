class FetchPersonShowsException implements Exception {
  FetchPersonShowsException(this.errorMessage);

  final String errorMessage;
}