import 'package:bloc/bloc.dart';

import '../../../../core/core.dart';
import '../../../../core/data/model/show_model.dart';
import '../../data/data.dart';
import 'show_details_state.dart';

class ShowDetailsCubit extends Cubit<ShowDetailsState> {
  ShowDetailsCubit({
    required ShowModel show,
    required ShowDetailsRepository showDetailsRepository,
    required ShowFavoriteInfoRepository showFavoriteInfoRepository,
  })  : _showDetailsRepository = showDetailsRepository,
        _showFavoriteInfoRepository = showFavoriteInfoRepository,
        super(ShowDetailsState.initial(show));

  final ShowDetailsRepository _showDetailsRepository;
  final ShowFavoriteInfoRepository _showFavoriteInfoRepository;

  void loadFavoritedInfo() {
    final isShowFavorited =
        _showFavoriteInfoRepository.isShowFavorited(state.show.id);

    emit(
      state.copyWith(
        isShowFavorited: isShowFavorited,
      ),
    );
  }

  void toggleFavoriteShow() {
    if (state.isShowFavorited!) {
      _showFavoriteInfoRepository.unfavoriteShow(state.show);
    } else {
      _showFavoriteInfoRepository.favoriteShow(state.show);
    }

    emit(
      state.copyWith(
        isShowFavorited: !state.isShowFavorited!,
      ),
    );
  }

  Future<void> fetchShowEpisodes() async {
    emit(
      state.copyWith(
        status: ShowDetailsStatus.loading,
      ),
    );

    try {
      final show = state.show;
      final episodes = await _showDetailsRepository.fetchEpisodes(show.id);
      emit(
        state.copyWith(
          status: ShowDetailsStatus.success,
          episodes: episodes,
        ),
      );
    } on FetchShowEpisodesException catch (e) {
      emit(
        state.copyWith(
          status: ShowDetailsStatus.failure,
          errorMessage: e.errorMessage,
        ),
      );
    } on UnknownException catch (e) {
      emit(
        state.copyWith(
          status: ShowDetailsStatus.failure,
          errorMessage: e.errorMessage,
        ),
      );
    }
  }
}
