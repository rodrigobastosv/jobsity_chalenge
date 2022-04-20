import 'package:bloc/bloc.dart';
import 'package:jobsity_chalenge/core/data/model/show_model.dart';

import '../../../../core/core.dart';
import '../../data/data.dart';
import 'show_details_state.dart';

class ShowDetailsCubit extends Cubit<ShowDetailsState> {
  ShowDetailsCubit({
    required ShowModel show,
    required ShowDetailsRepository repository,
  })  : _repository = repository,
        super(ShowDetailsState.initial(show));

  final ShowDetailsRepository _repository;

  Future<void> fetchShowEpisodes() async {
    emit(
      state.copyWith(
        status: ShowDetailsStatus.loading,
      ),
    );

    try {
      final show = state.show;
      final episodes = await _repository.fetchEpisodes(show.id);
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
