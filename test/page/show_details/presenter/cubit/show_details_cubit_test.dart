import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:jobsity_chalenge/core/core.dart';
import 'package:jobsity_chalenge/page/show_details/presenter/cubit/show_details_state.dart';
import 'package:jobsity_chalenge/page/show_details/show_details.dart';
import '../../../../data.dart';
import '../../../../mock.dart';

void main() {
  late ShowDetailsRepositoryMock showDetailsRepositoryMock;
  late ShowFavoriteInfoRepositoryMock showFavoriteInfoRepositoryMock;

  setUpAll(
    () {
      registerFallbackValue(ShowModelFake());
    },
  );

  setUp(
    () {
      showDetailsRepositoryMock = ShowDetailsRepositoryMock();
      showFavoriteInfoRepositoryMock = ShowFavoriteInfoRepositoryMock();
    },
  );

  test(
    'initial state is PeopleSearchState.initial()',
    () {
      final cubit = ShowDetailsCubit(
        show: showFake,
        showDetailsRepository: showDetailsRepositoryMock,
        showFavoriteInfoRepository: showFavoriteInfoRepositoryMock,
      );
      expect(cubit.state, ShowDetailsState.initial(showFake));
    },
  );

  blocTest<ShowDetailsCubit, ShowDetailsState>(
    'emits state with isShowFavorited property',
    build: () {
      when(() => showFavoriteInfoRepositoryMock.isShowFavorited(any()))
          .thenReturn(true);
      return ShowDetailsCubit(
        show: showFake,
        showDetailsRepository: showDetailsRepositoryMock,
        showFavoriteInfoRepository: showFavoriteInfoRepositoryMock,
      );
    },
    act: (cubit) => cubit.loadFavoritedInfo(),
    expect: () => [
      ShowDetailsState.initial(showFake).copyWith(
        isShowFavorited: true,
      ),
    ],
  );

  group(
    'toggleFavoriteShow',
    () {
      blocTest<ShowDetailsCubit, ShowDetailsState>(
        'should unfavorite if show is favorited',
        build: () {
          when(() => showFavoriteInfoRepositoryMock.unfavoriteShow(any()))
              .thenAnswer((_) async => {});
          return ShowDetailsCubit(
            show: showFake,
            showDetailsRepository: showDetailsRepositoryMock,
            showFavoriteInfoRepository: showFavoriteInfoRepositoryMock,
          );
        },
        act: (cubit) => cubit.toggleFavoriteShow(),
        seed: () => ShowDetailsState.initial(showFake).copyWith(
          isShowFavorited: true,
        ),
        expect: () => [
          ShowDetailsState.initial(showFake).copyWith(
            isShowFavorited: false,
          ),
        ],
        verify: (cubit) {
          verify(() => showFavoriteInfoRepositoryMock.unfavoriteShow(any()))
              .called(1);
        },
      );

      blocTest<ShowDetailsCubit, ShowDetailsState>(
        'should favorite if show is not favorited',
        build: () {
          when(() => showFavoriteInfoRepositoryMock.favoriteShow(any()))
              .thenAnswer((_) async => {});
          return ShowDetailsCubit(
            show: showFake,
            showDetailsRepository: showDetailsRepositoryMock,
            showFavoriteInfoRepository: showFavoriteInfoRepositoryMock,
          );
        },
        act: (cubit) => cubit.toggleFavoriteShow(),
        seed: () => ShowDetailsState.initial(showFake).copyWith(
          isShowFavorited: false,
        ),
        expect: () => [
          ShowDetailsState.initial(showFake).copyWith(
            isShowFavorited: true,
          ),
        ],
        verify: (cubit) {
          verify(() => showFavoriteInfoRepositoryMock.favoriteShow(any()))
              .called(1);
        },
      );
    },
  );

  group(
    'fetchShowEpisodes',
    () {
      blocTest<ShowDetailsCubit, ShowDetailsState>(
        'emits loading, success when fetchShowEpisodes is success',
        build: () {
          when(() => showDetailsRepositoryMock.fetchEpisodes(any())).thenAnswer(
            (_) async => [],
          );
          return ShowDetailsCubit(
            show: showFake,
            showDetailsRepository: showDetailsRepositoryMock,
            showFavoriteInfoRepository: showFavoriteInfoRepositoryMock,
          );
        },
        act: (cubit) => cubit.fetchShowEpisodes(),
        expect: () => [
          const ShowDetailsState(
            show: showFake,
            status: ShowDetailsStatus.loading,
            episodes: [],
            errorMessage: '',
            isShowFavorited: null,
            query: '',
          ),
          const ShowDetailsState(
            show: showFake,
            status: ShowDetailsStatus.success,
            episodes: [],
            errorMessage: '',
            isShowFavorited: null,
            query: '',
          ),
        ],
      );

      blocTest<ShowDetailsCubit, ShowDetailsState>(
        'emits failure with errorMessage when fetchShows throws FetchPersonShowsException',
        build: () {
          when(() => showDetailsRepositoryMock.fetchEpisodes(any())).thenThrow(
            FetchShowEpisodesException('error'),
          );
          return ShowDetailsCubit(
            show: showFake,
            showDetailsRepository: showDetailsRepositoryMock,
            showFavoriteInfoRepository: showFavoriteInfoRepositoryMock,
          );
        },
        act: (cubit) => cubit.fetchShowEpisodes(),
        expect: () => [
          const ShowDetailsState(
            show: showFake,
            status: ShowDetailsStatus.loading,
            episodes: [],
            errorMessage: '',
            isShowFavorited: null,
            query: '',
          ),
          const ShowDetailsState(
            show: showFake,
            status: ShowDetailsStatus.failure,
            episodes: [],
            errorMessage: 'error',
            isShowFavorited: null,
            query: '',
          ),
        ],
      );

      blocTest<ShowDetailsCubit, ShowDetailsState>(
        'emits failure with errorMessage when fetchShows throws UnknownException',
        build: () {
          when(() => showDetailsRepositoryMock.fetchEpisodes(any())).thenThrow(
            UnknownException(),
          );
          return ShowDetailsCubit(
            show: showFake,
            showDetailsRepository: showDetailsRepositoryMock,
            showFavoriteInfoRepository: showFavoriteInfoRepositoryMock,
          );
        },
        act: (cubit) => cubit.fetchShowEpisodes(),
        expect: () => [
          const ShowDetailsState(
            show: showFake,
            status: ShowDetailsStatus.loading,
            episodes: [],
            errorMessage: '',
            isShowFavorited: null,
            query: '',
          ),
          const ShowDetailsState(
            show: showFake,
            status: ShowDetailsStatus.failure,
            episodes: [],
            errorMessage: 'Unknown Error',
            isShowFavorited: null,
            query: '',
          ),
        ],
      );
    },
  );
}
