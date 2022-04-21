import 'package:bloc/bloc.dart';
import 'package:jobsity_chalenge/core/core.dart';
import 'package:jobsity_chalenge/page/favorite_shows/favorite_shows.dart';

import 'favorite_shows_state.dart';

class FavoriteShowsCubit extends Cubit<FavoriteShowsState> {
  FavoriteShowsCubit({
    required FavoriteShowsRepository repository,
  })  : _repository = repository,
        super(FavoriteShowsState.initial());

  final FavoriteShowsRepository _repository;

  Future<void> fetchFavoriteShows() async {
    try {
      final favoriteShows = await _repository.fetchFavoriteShows();

      emit(
        state.copyWith(
          status: FavoriteShowsStatus.success,
          shows: favoriteShows,
        ),
      );
    } on FavoriteShowsException catch (e) {
      emit(
        state.copyWith(
          status: FavoriteShowsStatus.failure,
          errorMessage: e.errorMessage
        ),
      );
    } on UnknownException catch (e) {
      emit(
        state.copyWith(
          status: FavoriteShowsStatus.failure,
          errorMessage: e.errorMessage,
        ),
      );
    }
  }

  Future<void> deleteFavoriteShow(int showId) async {
    try {
      await _repository.removeFavoriteShow(showId);
      final favoriteShows = await _repository.fetchFavoriteShows();

      emit(
        state.copyWith(
          status: FavoriteShowsStatus.success,
          shows: favoriteShows,
        ),
      );
    } on FavoriteShowsException catch (e) {
      emit(
        state.copyWith(
          status: FavoriteShowsStatus.failure,
          errorMessage: e.errorMessage
        ),
      );
    } on UnknownException catch (e) {
      emit(
        state.copyWith(
          status: FavoriteShowsStatus.failure,
          errorMessage: e.errorMessage,
        ),
      );
    }
  }
}
