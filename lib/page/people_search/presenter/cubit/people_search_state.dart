import 'package:equatable/equatable.dart';

import '../../people_search.dart';

enum PeopleSearchStatus {
  initial,
  loading,
  success,
  failure,
}

class PeopleSearchState extends Equatable {
  final List<PersonModel> people;
  final PeopleSearchStatus status;
  final String query;
  final String errorMessage;
  final int page;

  const PeopleSearchState({
    required this.people,
    required this.status,
    required this.query,
    required this.errorMessage,
    required this.page,
  });

  factory PeopleSearchState.initial() => const PeopleSearchState(
        people: [],
        status: PeopleSearchStatus.initial,
        query: '',
        errorMessage: '',
        page: 0,
      );

  PeopleSearchState copyWith({
    List<PersonModel>? people,
    PeopleSearchStatus? status,
    String? query,
    String? errorMessage,
    int? page,
  }) {
    return PeopleSearchState(
      people: people ?? this.people,
      status: status ?? this.status,
      query: query ?? this.query,
      errorMessage: errorMessage ?? this.errorMessage,
      page: page ?? this.page,
    );
  }

  @override
  List<Object?> get props => [
        people,
        status,
        query,
        errorMessage,
      ];
}
