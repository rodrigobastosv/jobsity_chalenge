import 'package:bloc/bloc.dart';
import 'package:jobsity_chalenge/page/sign_in/sign_in.dart';

import 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({
    required SignInRepository repository,
  })  : _repository = repository,
        super(SignInState.initial());

  final SignInRepository _repository;

  Future<void> signInUser(String pin) async {
    final signInSuccess = await _repository.signInUser(pin);
 
    emit(
      state.copyWith(
        status: signInSuccess ? SignInStatus.success : SignInStatus.failure,
      ),
    );
  }
}
