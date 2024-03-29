import 'package:bloc/bloc.dart';

import '../../../../core/core.dart';
import '../../data/exception/exception.dart';
import '../../data/repository/home_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required HomeRepository repository,
  })  : _repository = repository,
        super(HomeState.initial());

  final HomeRepository _repository;

  void onChangeQuery(String query) {
    emit(
      state.copyWith(
        query: query,
      ),
    );
  }

  Future<void> fetchShowsByPage() async {
    emit(
      state.copyWith(
        status: HomeStatus.loading,
      ),
    );

    try {
      final shows = await _repository.fetchShows(state.page);
      emit(
        state.copyWith(
          status: HomeStatus.success,
          shows: [
            ...state.shows,
            ...shows,
          ],
          page: state.page + 1,
        ),
      );
    } on FetchShowException catch (e) {
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          shows: [],
          errorMessage: e.errorMessage,
        ),
      );
    } on UnknownException catch (e) {
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          shows: [],
          errorMessage: e.errorMessage,
        ),
      );
    }
  }

  Future<void> fetchShowsByQuery() async {
    if (state.query.isEmpty) {
      emit(
        state.copyWith(
          page: 0,
        ),
      );
      await fetchShowsByPage();
    } else {
      emit(
        state.copyWith(
          status: HomeStatus.loading,
        ),
      );

      try {
        final shows = await _repository.fetchShowsByQuery(state.query);
        emit(
          state.copyWith(
            status: HomeStatus.success,
            shows: shows,
          ),
        );
      } on FetchShowException catch (e) {
        emit(
          state.copyWith(
            status: HomeStatus.failure,
            shows: [],
            errorMessage: e.errorMessage,
          ),
        );
      } on UnknownException catch (e) {
        emit(
          state.copyWith(
            status: HomeStatus.failure,
            shows: [],
            errorMessage: e.errorMessage,
          ),
        );
      }
    }
  }
}
