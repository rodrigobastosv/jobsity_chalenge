import 'package:bloc/bloc.dart';

import '../../data/data.dart';
import 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({
    required SignUpRepository repository,
  })  : _repository = repository,
        super(SignUpState.initial());

  final SignUpRepository _repository;

  Future<void> signUpUser(String pin) async {
    try {
      await _repository.signUpUser(pin);

      emit(
        state.copyWith(
          status: SignUpStatus.success,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: SignUpStatus.failure,
        ),
      );
    }
  }
}
