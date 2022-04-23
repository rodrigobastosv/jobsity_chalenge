import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jobsity_chalenge/core/core.dart';
import 'package:jobsity_chalenge/page/home/data/exception/exception.dart';
import 'package:jobsity_chalenge/page/home/home.dart';
import 'package:jobsity_chalenge/page/home/presenter/cubit/home_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../data.dart';
import '../../../../mock.dart';

void main() {
  late HomeRepositoryMock repositoryMock;

  setUp(
    () {
      repositoryMock = HomeRepositoryMock();
    },
  );

  test(
    'initial state is HomeState.initial()',
    () {
      final cubit = HomeCubit(
        repository: repositoryMock,
      );
      expect(cubit.state, HomeState.initial());
    },
  );

  blocTest<HomeCubit, HomeState>(
    'emits state with new query when onChangeQuery is called',
    build: () {
      return HomeCubit(
        repository: repositoryMock,
      );
    },
    act: (cubit) => cubit.onChangeQuery('mike'),
    expect: () => [
      HomeState.initial().copyWith(
        query: 'mike',
      ),
    ],
  );

  group(
    'fetchShowsByPage',
    () {
      blocTest<HomeCubit, HomeState>(
        'emits loading and success when fetchFavoriteShows is success',
        build: () {
          when(() => repositoryMock.fetchShows(1)).thenAnswer(
            (_) async => [
              showFake,
              showFake,
            ],
          );
          return HomeCubit(
            repository: repositoryMock,
          );
        },
        act: (cubit) => cubit.fetchShowsByPage(1),
        expect: () => [
          const HomeState(
            status: HomeStatus.loading,
            shows: [],
            query: '',
            errorMessage: '',
          ),
          const HomeState(
            status: HomeStatus.success,
            shows: [
              showFake,
              showFake,
            ],
            query: '',
            errorMessage: '',
          ),
        ],
      );

      blocTest<HomeCubit, HomeState>(
        'emits loading, failure with errorMessage when fetchShowsByPage throws FetchShowException',
        build: () {
          when(() => repositoryMock.fetchShows(1)).thenThrow(
            FetchShowException('error'),
          );
          return HomeCubit(
            repository: repositoryMock,
          );
        },
        act: (cubit) => cubit.fetchShowsByPage(1),
        expect: () => [
          const HomeState(
            status: HomeStatus.loading,
            shows: [],
            query: '',
            errorMessage: '',
          ),
          const HomeState(
            status: HomeStatus.failure,
            shows: [],
            query: '',
            errorMessage: 'error',
          ),
        ],
      );

      blocTest<HomeCubit, HomeState>(
        'emits loading, failure with errorMessage when fetchShowsByPage throws UnknownException',
        build: () {
          when(() => repositoryMock.fetchShows(1)).thenThrow(
            UnknownException(),
          );
          return HomeCubit(
            repository: repositoryMock,
          );
        },
        act: (cubit) => cubit.fetchShowsByPage(1),
        expect: () => [
          const HomeState(
            status: HomeStatus.loading,
            shows: [],
            query: '',
            errorMessage: '',
          ),
          const HomeState(
            status: HomeStatus.failure,
            shows: [],
            query: '',
            errorMessage: 'Unknown Error',
          ),
        ],
      );
    },
  );

  group(
    'fetchShowsByQuery',
    () {
      blocTest<HomeCubit, HomeState>(
        'call fetchShowsByPage with page 0 when query is empty',
        build: () {
          when(() => repositoryMock.fetchShows(0)).thenAnswer(
            (_) async => [
              showFake,
              showFake,
            ],
          );
          return HomeCubit(
            repository: repositoryMock,
          );
        },
        act: (cubit) => cubit.fetchShowsByQuery(),
        expect: () => [
          const HomeState(
            status: HomeStatus.loading,
            shows: [],
            query: '',
            errorMessage: '',
          ),
          const HomeState(
            status: HomeStatus.success,
            shows: [
              showFake,
              showFake,
            ],
            query: '',
            errorMessage: '',
          ),
        ],
      );

      blocTest<HomeCubit, HomeState>(
        'emits loading, success with errorMessage when fetchShowsByQuery is success',
        build: () {
          when(() => repositoryMock.fetchShowsByQuery('mike')).thenAnswer(
            (_) async => [
              showFake,
              showFake,
            ],
          );
          return HomeCubit(
            repository: repositoryMock,
          );
        },
        act: (cubit) => cubit.fetchShowsByQuery(),
        seed: () => const HomeState(
          status: HomeStatus.loading,
          shows: [],
          query: 'mike',
          errorMessage: '',
        ),
        expect: () => [
          const HomeState(
            status: HomeStatus.success,
            shows: [
              showFake,
              showFake,
            ],
            query: 'mike',
            errorMessage: '',
          ),
        ],
      );

      blocTest<HomeCubit, HomeState>(
        'emits loading, failure with errorMessage when fetchShowsByQuery throws FetchShowException',
        build: () {
          when(() => repositoryMock.fetchShowsByQuery('mike')).thenThrow(
            FetchShowException('error'),
          );
          return HomeCubit(
            repository: repositoryMock,
          );
        },
        act: (cubit) => cubit.fetchShowsByQuery(),
        seed: () => const HomeState(
          status: HomeStatus.loading,
          shows: [],
          query: 'mike',
          errorMessage: '',
        ),
        expect: () => [
          const HomeState(
            status: HomeStatus.failure,
            shows: [],
            query: 'mike',
            errorMessage: 'error',
          ),
        ],
      );

      blocTest<HomeCubit, HomeState>(
        'emits loading, failure with errorMessage when fetchShowsByQuery throws UnknownException',
        build: () {
          when(() => repositoryMock.fetchShowsByQuery('mike')).thenThrow(
            UnknownException(),
          );
          return HomeCubit(
            repository: repositoryMock,
          );
        },
        act: (cubit) => cubit.fetchShowsByQuery(),
        seed: () => const HomeState(
          status: HomeStatus.loading,
          shows: [],
          query: 'mike',
          errorMessage: '',
        ),
        expect: () => [
          const HomeState(
            status: HomeStatus.failure,
            shows: [],
            query: 'mike',
            errorMessage: 'Unknown Error',
          ),
        ],
      );
    },
  );
}
