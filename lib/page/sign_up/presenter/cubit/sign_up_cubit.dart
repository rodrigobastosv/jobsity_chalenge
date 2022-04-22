import 'package:bloc/bloc.dart';

import 'package:jobsity_chalenge/page/sign_up/presenter/cubit/sign_up_state.dart';
import '../../data/data.dart';

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
