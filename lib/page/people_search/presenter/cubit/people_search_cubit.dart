import 'package:bloc/bloc.dart';

import 'package:jobsity_chalenge/page/people_search/data/data.dart';
import '../../../../core/core.dart';
import 'people_search_state.dart';

class PeopleSearchCubit extends Cubit<PeopleSearchState> {
  PeopleSearchCubit({
    required PeopleSearchRepository repository,
  })  : _repository = repository,
        super(PeopleSearchState.initial());

  final PeopleSearchRepository _repository;

  void onChangeQuery(String query) {
    emit(
      state.copyWith(
        query: query,
      ),
    );
  }

  Future<void> fetchPeople() async {
    emit(
      state.copyWith(
        status: PeopleSearchStatus.loading,
      ),
    );

    try {
      final people = await _repository.fetchPeople();
      emit(
        state.copyWith(
          status: PeopleSearchStatus.success,
          people: people,
        ),
      );
    } on FetchPeopleSearchException catch (e) {
      emit(
        state.copyWith(
          status: PeopleSearchStatus.failure,
          errorMessage: e.errorMessage,
        ),
      );
    } on UnknownException catch (e) {
      emit(
        state.copyWith(
          status: PeopleSearchStatus.failure,
          errorMessage: e.errorMessage,
        ),
      );
    }
  }

  Future<void> fetchPeopleByQuery() async {
    emit(
      state.copyWith(
        status: PeopleSearchStatus.loading,
      ),
    );

    try {
      final people = await _repository.fetchPeopleByQuery(state.query);
      emit(
        state.copyWith(
          status: PeopleSearchStatus.success,
          people: people,
        ),
      );
    } on FetchPeopleSearchException catch (e) {
      emit(
        state.copyWith(
          status: PeopleSearchStatus.failure,
          people: [],
          errorMessage: e.errorMessage,
        ),
      );
    } on UnknownException catch (e) {
      emit(
        state.copyWith(
          status: PeopleSearchStatus.failure,
          people: [],
          errorMessage: e.errorMessage,
        ),
      );
    }
  }
}
