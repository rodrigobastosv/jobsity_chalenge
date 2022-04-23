import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jobsity_chalenge/core/core.dart';
import 'package:jobsity_chalenge/page/favorite_shows/favorite_shows.dart';
import 'package:jobsity_chalenge/page/favorite_shows/presenter/cubit/favorite_shows_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mock.dart';

void main() {
  late FavoriteShowsRepositoryMock repositoryMock;

  setUp(
    () {
      repositoryMock = FavoriteShowsRepositoryMock();
    },
  );

  test(
    'initial state is FavoriteShowsState.initial()',
    () {
      final cubit = FavoriteShowsCubit(
        repository: repositoryMock,
      );
      expect(cubit.state, FavoriteShowsState.initial());
    },
  );

  group(
    'fetchFavoriteShows',
    () {
      blocTest<FavoriteShowsCubit, FavoriteShowsState>(
        'emits success when fetchFavoriteShows is success',
        build: () {
          when(() => repositoryMock.fetchFavoriteShows()).thenAnswer(
            (_) async => [],
          );
          return FavoriteShowsCubit(
            repository: repositoryMock,
          );
        },
        act: (cubit) => cubit.fetchFavoriteShows(),
        expect: () => [
          const FavoriteShowsState(
            status: FavoriteShowsStatus.success,
            shows: [],
            errorMessage: '',
          ),
        ],
      );

      blocTest<FavoriteShowsCubit, FavoriteShowsState>(
        'emits failure with errorMessage when fetchFavoriteShows throws FavoriteShowsException',
        build: () {
          when(() => repositoryMock.fetchFavoriteShows()).thenThrow(
            FavoriteShowsException('error'),
          );
          return FavoriteShowsCubit(
            repository: repositoryMock,
          );
        },
        act: (cubit) => cubit.fetchFavoriteShows(),
        expect: () => [
          const FavoriteShowsState(
            status: FavoriteShowsStatus.failure,
            shows: [],
            errorMessage: 'error',
          ),
        ],
      );

      blocTest<FavoriteShowsCubit, FavoriteShowsState>(
        'emits failure with errorMessage when fetchFavoriteShows throws UnknownException',
        build: () {
          when(() => repositoryMock.fetchFavoriteShows()).thenThrow(
            UnknownException(),
          );
          return FavoriteShowsCubit(
            repository: repositoryMock,
          );
        },
        act: (cubit) => cubit.fetchFavoriteShows(),
        expect: () => [
          const FavoriteShowsState(
            status: FavoriteShowsStatus.failure,
            shows: [],
            errorMessage: 'Unknown Error',
          ),
        ],
      );
    },
  );

  group(
    'deleteFavoriteShow',
    () {
      blocTest<FavoriteShowsCubit, FavoriteShowsState>(
        'emits success when deleteFavoriteShow is success',
        build: () {
          when(() => repositoryMock.removeFavoriteShow(any())).thenAnswer(
            (_) async => {},
          );
          when(() => repositoryMock.fetchFavoriteShows()).thenAnswer(
            (_) async => [],
          );
          return FavoriteShowsCubit(
            repository: repositoryMock,
          );
        },
        act: (cubit) => cubit.deleteFavoriteShow(1),
        expect: () => [
          const FavoriteShowsState(
            status: FavoriteShowsStatus.success,
            shows: [],
            errorMessage: '',
          ),
        ],
      );

      blocTest<FavoriteShowsCubit, FavoriteShowsState>(
        'emits failure with errorMessage when deleteFavoriteShow throws FavoriteShowsException',
        build: () {
          when(() => repositoryMock.removeFavoriteShow(any())).thenThrow(
            FavoriteShowsException('error'),
          );
          return FavoriteShowsCubit(
            repository: repositoryMock,
          );
        },
        act: (cubit) => cubit.deleteFavoriteShow(1),
        expect: () => [
          const FavoriteShowsState(
            status: FavoriteShowsStatus.failure,
            shows: [],
            errorMessage: 'error',
          ),
        ],
      );

      blocTest<FavoriteShowsCubit, FavoriteShowsState>(
        'emits failure with errorMessage when deleteFavoriteShow throws UnknownException',
        build: () {
          when(() => repositoryMock.removeFavoriteShow(any())).thenThrow(
            UnknownException(),
          );
          return FavoriteShowsCubit(
            repository: repositoryMock,
          );
        },
        act: (cubit) => cubit.deleteFavoriteShow(1),
        expect: () => [
          const FavoriteShowsState(
            status: FavoriteShowsStatus.failure,
            shows: [],
            errorMessage: 'Unknown Error',
          ),
        ],
      );
    },
  );
}
