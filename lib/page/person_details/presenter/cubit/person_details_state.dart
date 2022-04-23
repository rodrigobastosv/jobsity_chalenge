import 'package:equatable/equatable.dart';

import '../../../../core/data/model/show_model.dart';
import '../../../people_search/data/data.dart';

enum PersonDetailsStatus {
  initial,
  loading,
  success,
  failure,
}

class PersonDetailsState extends Equatable {
  final PersonModel person;
  final List<ShowModel> shows;
  final PersonDetailsStatus status;
  final String errorMessage;

  const PersonDetailsState({
    required this.person,
    required this.shows,
    required this.status,
    required this.errorMessage,
  });

  factory PersonDetailsState.initial(PersonModel person) => PersonDetailsState(
        person: person,
        shows: const [],
        status: PersonDetailsStatus.initial,
        errorMessage: '',
      );

  PersonDetailsState copyWith({
    PersonModel? person,
    List<ShowModel>? shows,
    PersonDetailsStatus? status,
    String? errorMessage,
  }) {
    return PersonDetailsState(
      person: person ?? this.person,
      shows: shows ?? this.shows,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        person,
        shows,
        status,
        errorMessage,
      ];
}
