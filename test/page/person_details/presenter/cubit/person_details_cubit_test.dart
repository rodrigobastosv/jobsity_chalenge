import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:jobsity_chalenge/core/core.dart';
import 'package:jobsity_chalenge/page/person_details/data/data.dart';
import 'package:jobsity_chalenge/page/person_details/presenter/cubit/person_details_cubit.dart';
import 'package:jobsity_chalenge/page/person_details/presenter/cubit/person_details_state.dart';
import '../../../../data.dart';
import '../../../../mock.dart';

void main() {
  late PersonDetailsRepositoryMock repositoryMock;

  setUp(
    () {
      repositoryMock = PersonDetailsRepositoryMock();
    },
  );

  test(
    'initial state is PeopleSearchState.initial()',
    () {
      final cubit = PersonDetailsCubit(
        person: personFake,
        repository: repositoryMock,
      );
      expect(cubit.state, PersonDetailsState.initial(personFake));
    },
  );

  group(
    'fetchShows',
    () {
      blocTest<PersonDetailsCubit, PersonDetailsState>(
        'emits loading, success when fetchShows is success',
        build: () {
          when(() => repositoryMock.fetchShows(any())).thenAnswer(
            (_) async => [
              showFake,
              showFake,
            ],
          );
          return PersonDetailsCubit(
            person: personFake,
            repository: repositoryMock,
          );
        },
        act: (cubit) => cubit.fetchShows(),
        expect: () => [
          const PersonDetailsState(
            status: PersonDetailsStatus.loading,
            person: personFake,
            shows: [],
            errorMessage: '',
          ),
          const PersonDetailsState(
            status: PersonDetailsStatus.success,
            person: personFake,
            shows: [
              showFake,
              showFake,
            ],
            errorMessage: '',
          ),
        ],
      );

      blocTest<PersonDetailsCubit, PersonDetailsState>(
        'emits failure with errorMessage when fetchShows throws FetchPersonShowsException',
        build: () {
          when(() => repositoryMock.fetchShows(any())).thenThrow(
            FetchPersonShowsException('error'),
          );
          return PersonDetailsCubit(
            person: personFake,
            repository: repositoryMock,
          );
        },
        act: (cubit) => cubit.fetchShows(),
        expect: () => [
          const PersonDetailsState(
            status: PersonDetailsStatus.loading,
            person: personFake,
            shows: [],
            errorMessage: '',
          ),
          const PersonDetailsState(
            status: PersonDetailsStatus.failure,
            person: personFake,
            shows: [],
            errorMessage: 'error',
          ),
        ],
      );

      blocTest<PersonDetailsCubit, PersonDetailsState>(
        'emits failure with errorMessage when fetchShows throws UnknownException',
        build: () {
          when(() => repositoryMock.fetchShows(any())).thenThrow(
            UnknownException(),
          );
          return PersonDetailsCubit(
            person: personFake,
            repository: repositoryMock,
          );
        },
        act: (cubit) => cubit.fetchShows(),
        expect: () => [
          const PersonDetailsState(
            status: PersonDetailsStatus.loading,
            person: personFake,
            shows: [],
            errorMessage: '',
          ),
          const PersonDetailsState(
            status: PersonDetailsStatus.failure,
            person: personFake,
            shows: [],
            errorMessage: 'Unknown Error',
          ),
        ],
      );
    },
  );
}
