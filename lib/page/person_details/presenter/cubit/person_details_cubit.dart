import 'package:bloc/bloc.dart';

import '../../../../core/core.dart';
import '../../../people_search/data/data.dart';
import '../../data/data.dart';
import 'person_details_state.dart';

class PersonDetailsCubit extends Cubit<PersonDetailsState> {
  PersonDetailsCubit({
    required PersonModel person,
    required PersonDetailsRepository repository,
  })  : _repository = repository,
        super(PersonDetailsState.initial(person));

  final PersonDetailsRepository _repository;

  Future<void> fetchShows() async {
    emit(
      state.copyWith(
        status: PersonDetailsStatus.loading,
      ),
    );

    try {
      final person = state.person;
      final shows = await _repository.fetchShows(person.id);
      emit(
        state.copyWith(
          status: PersonDetailsStatus.success,
          shows: shows,
        ),
      );
    } on FetchPersonShowsException catch (e) {
      emit(
        state.copyWith(
          status: PersonDetailsStatus.failure,
          errorMessage: e.errorMessage,
        ),
      );
    } on UnknownException catch (e) {
      emit(
        state.copyWith(
          status: PersonDetailsStatus.failure,
          errorMessage: e.errorMessage,
        ),
      );
    }
  }
}
