import 'package:equatable/equatable.dart';
import 'package:jobsity_chalenge/page/people_search/people_search.dart';

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

  const PeopleSearchState({
    required this.people,
    required this.status,
    required this.query,
    required this.errorMessage,
  });

  factory PeopleSearchState.initial() => const PeopleSearchState(
        people: [],
        status: PeopleSearchStatus.initial,
        query: '',
        errorMessage: '',
      );

  PeopleSearchState copyWith({
    List<PersonModel>? people,
    PeopleSearchStatus? status,
    String? query,
    String? errorMessage,
  }) {
    return PeopleSearchState(
      people: people ?? this.people,
      status: status ?? this.status,
      query: query ?? this.query,
      errorMessage: errorMessage ?? this.errorMessage,
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
