import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:jobsity_chalenge/core/core.dart';
import 'package:jobsity_chalenge/page/people_search/data/data.dart';
import 'package:jobsity_chalenge/page/people_search/presenter/cubit/people_search_state.dart';
import 'package:jobsity_chalenge/page/people_search/presenter/presenter.dart';
import '../../../../mock.dart';

void main() {
  late PeopleSearchRepositoryMock repositoryMock;

  setUp(
    () {
      repositoryMock = PeopleSearchRepositoryMock();
    },
  );

  test(
    'initial state is PeopleSearchState.initial()',
    () {
      final cubit = PeopleSearchCubit(
        repository: repositoryMock,
      );
      expect(cubit.state, PeopleSearchState.initial());
    },
  );

  blocTest<PeopleSearchCubit, PeopleSearchState>(
    'emits state with new query when onChangeQuery is called',
    build: () {
      return PeopleSearchCubit(
        repository: repositoryMock,
      );
    },
    act: (cubit) => cubit.onChangeQuery('mike'),
    expect: () => [
      PeopleSearchState.initial().copyWith(
        query: 'mike',
      ),
    ],
  );

  group(
    'fetchPeople',
    () {
      blocTest<PeopleSearchCubit, PeopleSearchState>(
        'emits loading, success when fetchPeople is success',
        build: () {
          when(() => repositoryMock.fetchPeopleByPage(0)).thenAnswer(
            (_) async => [],
          );
          return PeopleSearchCubit(
            repository: repositoryMock,
          );
        },
        act: (cubit) => cubit.fetchPeople(),
        expect: () => [
          const PeopleSearchState(
            status: PeopleSearchStatus.loading,
            people: [],
            query: '',
            errorMessage: '',
            page: 0,
          ),
          const PeopleSearchState(
            status: PeopleSearchStatus.success,
            people: [],
            query: '',
            errorMessage: '',
            page: 1,
          ),
        ],
      );

      blocTest<PeopleSearchCubit, PeopleSearchState>(
        'emits failure with errorMessage when fetchPeople throws FetchPeopleSearchException',
        build: () {
          when(() => repositoryMock.fetchPeopleByPage(0)).thenThrow(
            FetchPeopleSearchException('error'),
          );
          return PeopleSearchCubit(
            repository: repositoryMock,
          );
        },
        act: (cubit) => cubit.fetchPeople(),
        expect: () => [
          const PeopleSearchState(
            status: PeopleSearchStatus.loading,
            people: [],
            query: '',
            errorMessage: '',
            page: 0,
          ),
          const PeopleSearchState(
            status: PeopleSearchStatus.failure,
            people: [],
            query: '',
            errorMessage: 'error',
            page: 1,
          ),
        ],
      );

      blocTest<PeopleSearchCubit, PeopleSearchState>(
        'emits failure with errorMessage when fetchPeople throws UnknownException',
        build: () {
          when(() => repositoryMock.fetchPeopleByPage(0)).thenThrow(
            UnknownException(),
          );
          return PeopleSearchCubit(
            repository: repositoryMock,
          );
        },
        act: (cubit) => cubit.fetchPeople(),
        expect: () => [
          const PeopleSearchState(
            status: PeopleSearchStatus.loading,
            people: [],
            query: '',
            errorMessage: '',
            page: 0,
          ),
          const PeopleSearchState(
            status: PeopleSearchStatus.failure,
            people: [],
            query: '',
            errorMessage: 'Unknown Error',
            page: 1,
          ),
        ],
      );
    },
  );

  group(
    'fetchPeopleByQuery',
    () {
      blocTest<PeopleSearchCubit, PeopleSearchState>(
        'emits loading, success when fetchPeopleByQuery is success',
        build: () {
          when(() => repositoryMock.fetchPeopleByQuery('mike')).thenAnswer(
            (_) async => [],
          );
          return PeopleSearchCubit(
            repository: repositoryMock,
          );
        },
        act: (cubit) => cubit.fetchPeopleByQuery(),
        seed: () => const PeopleSearchState(
          status: PeopleSearchStatus.initial,
          people: [],
          query: 'mike',
          errorMessage: '',
          page: 0,
        ),
        expect: () => [
          const PeopleSearchState(
            status: PeopleSearchStatus.loading,
            people: [],
            query: 'mike',
            errorMessage: '',
            page: 0,
          ),
          const PeopleSearchState(
            status: PeopleSearchStatus.success,
            people: [],
            query: 'mike',
            errorMessage: '',
            page: 0,
          ),
        ],
      );

      blocTest<PeopleSearchCubit, PeopleSearchState>(
        'emits failure with errorMessage when fetchPeopleByQuery throws FetchPeopleSearchException',
        build: () {
          when(() => repositoryMock.fetchPeopleByQuery('mike')).thenThrow(
            FetchPeopleSearchException('error'),
          );
          return PeopleSearchCubit(
            repository: repositoryMock,
          );
        },
        act: (cubit) => cubit.fetchPeopleByQuery(),
        seed: () => const PeopleSearchState(
          status: PeopleSearchStatus.initial,
          people: [],
          query: 'mike',
          errorMessage: '',
          page: 0,
        ),
        expect: () => [
          const PeopleSearchState(
            status: PeopleSearchStatus.loading,
            people: [],
            query: 'mike',
            errorMessage: '',
            page: 0,
          ),
          const PeopleSearchState(
            status: PeopleSearchStatus.failure,
            people: [],
            query: 'mike',
            errorMessage: 'error',
            page: 0,
          ),
        ],
      );

      blocTest<PeopleSearchCubit, PeopleSearchState>(
        'emits failure with errorMessage when fetchPeopleByQuery throws UnknownException',
        build: () {
          when(() => repositoryMock.fetchPeopleByQuery('mike')).thenThrow(
            UnknownException(),
          );
          return PeopleSearchCubit(
            repository: repositoryMock,
          );
        },
        act: (cubit) => cubit.fetchPeopleByQuery(),
        seed: () => const PeopleSearchState(
          status: PeopleSearchStatus.initial,
          people: [],
          query: 'mike',
          errorMessage: '',
          page: 0,
        ),
        expect: () => [
          const PeopleSearchState(
            status: PeopleSearchStatus.loading,
            people: [],
            query: 'mike',
            errorMessage: '',
            page: 0,
          ),
          const PeopleSearchState(
            status: PeopleSearchStatus.failure,
            people: [],
            query: 'mike',
            errorMessage: 'Unknown Error',
            page: 0,
          ),
        ],
      );
    },
  );
}
