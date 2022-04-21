class FetchPeopleSearchException implements Exception {
  FetchPeopleSearchException(this.errorMessage);

  final String errorMessage;
}