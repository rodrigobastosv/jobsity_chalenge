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
  final String errorMessage;

  const PeopleSearchState({
    required this.people,
    required this.status,
    required this.errorMessage,
  });

  factory PeopleSearchState.initial() => const PeopleSearchState(
        people: [],
        status: PeopleSearchStatus.initial,
        errorMessage: '',
      );

  PeopleSearchState copyWith({
    List<PersonModel>? people,
    PeopleSearchStatus? status,
    String? errorMessage,
  }) {
    return PeopleSearchState(
      people: people ?? this.people,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        people,
        status,
        errorMessage,
      ];
}
