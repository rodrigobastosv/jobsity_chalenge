import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:jobsity_chalenge/page/sign_in/sign_in.dart';
import 'package:local_auth/local_auth.dart';
import 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({
    required LocalAuthentication localAuthentication,
    required Box userPinBox,
    required SignInRepository repository,
  })  : _localAuthentication = localAuthentication,
        _userPinBox = userPinBox,
        _repository = repository,
        super(SignInState.initial());

  final LocalAuthentication _localAuthentication;
  final Box _userPinBox;
  final SignInRepository _repository;

  void onChangePin(String pin) {
    emit(
      state.copyWith(
        status: SignInStatus.initial,
        pin: pin,
      ),
    );
  }

  Future<void> checkForBioSupport() async {
    emit(
      state.copyWith(
        status: SignInStatus.loading,
      ),
    );

    final canCheckBiometrics = await _localAuthentication.canCheckBiometrics &&
        await _localAuthentication.isDeviceSupported();
    final userPin = _userPinBox.get('USER_PIN');

    emit(
      state.copyWith(
        status: SignInStatus.initial,
        canCheckBiometrics: canCheckBiometrics && userPin != null,
      ),
    );
  }

  Future<void> authWithFingeprint() async {
    final didAuthenticate = await _localAuthentication.authenticate(
      localizedReason: 'Please authenticate to show info about shows!',
    );

    emit(
      state.copyWith(
        status: didAuthenticate ? SignInStatus.success : SignInStatus.failure,
      ),
    );
  }

  Future<void> signInUser(String pin) async {
    final signInSuccess = await _repository.signInUser(pin);

    emit(
      state.copyWith(
        status: signInSuccess ? SignInStatus.success : SignInStatus.failure,
      ),
    );
  }
}
