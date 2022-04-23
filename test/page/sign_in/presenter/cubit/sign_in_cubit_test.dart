import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jobsity_chalenge/page/sign_in/presenter/cubit/sign_in_state.dart';
import 'package:jobsity_chalenge/page/sign_in/presenter/presenter.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mock.dart';

void main() {
  late LocalAuthenticationMock localAuthenticationMock;
  late BoxMock userPinBoxMock;
  late SignInRepositoryMock repositoryMock;

  setUp(
    () {
      localAuthenticationMock = LocalAuthenticationMock();
      userPinBoxMock = BoxMock();
      repositoryMock = SignInRepositoryMock();
    },
  );

  test(
    'initial state is SignInState.initial()',
    () {
      final cubit = SignInCubit(
        localAuthentication: localAuthenticationMock,
        userPinBox: userPinBoxMock,
        repository: repositoryMock,
      );
      expect(cubit.state, SignInState.initial());
    },
  );

  blocTest<SignInCubit, SignInState>(
    'emits state with new query when onChangePin is called',
    build: () {
      return SignInCubit(
        localAuthentication: localAuthenticationMock,
        userPinBox: userPinBoxMock,
        repository: repositoryMock,
      );
    },
    act: (cubit) => cubit.onChangePin('1234'),
    expect: () => [
      const SignInState(
        pin: '1234',
        canCheckBiometrics: null,
        status: SignInStatus.initial,
      ),
    ],
  );

  group(
    'checkForBioSupport',
    () {
      blocTest<SignInCubit, SignInState>(
        'emits loading, initial when checkForBioSupport is success',
        build: () {
          when(() => localAuthenticationMock.canCheckBiometrics).thenAnswer(
            (_) async => true,
          );
          when(() => localAuthenticationMock.isDeviceSupported()).thenAnswer(
            (_) async => true,
          );
          when(() => userPinBoxMock.get(any())).thenAnswer(
            (_) async => 1,
          );
          return SignInCubit(
            localAuthentication: localAuthenticationMock,
            userPinBox: userPinBoxMock,
            repository: repositoryMock,
          );
        },
        act: (cubit) => cubit.checkForBioSupport(),
        expect: () => [
          const SignInState(
            pin: '',
            canCheckBiometrics: null,
            status: SignInStatus.loading,
          ),
          const SignInState(
            pin: '',
            canCheckBiometrics: true,
            status: SignInStatus.initial,
          ),
        ],
      );
    },
  );

  group(
    'authWithFingeprint',
    () {
      blocTest<SignInCubit, SignInState>(
        'emits success when authWithFingeprint is success',
        build: () {
          when(() => localAuthenticationMock.authenticate(
              localizedReason: any(named: 'localizedReason'))).thenAnswer(
            (_) async => true,
          );
          return SignInCubit(
            localAuthentication: localAuthenticationMock,
            userPinBox: userPinBoxMock,
            repository: repositoryMock,
          );
        },
        act: (cubit) => cubit.authWithFingeprint(),
        expect: () => [
          const SignInState(
            pin: '',
            canCheckBiometrics: null,
            status: SignInStatus.success,
          ),
        ],
      );

      blocTest<SignInCubit, SignInState>(
        'emits failure when authWithFingeprint is not success',
        build: () {
          when(() => localAuthenticationMock.authenticate(
              localizedReason: any(named: 'localizedReason'))).thenAnswer(
            (_) async => false,
          );
          return SignInCubit(
            localAuthentication: localAuthenticationMock,
            userPinBox: userPinBoxMock,
            repository: repositoryMock,
          );
        },
        act: (cubit) => cubit.authWithFingeprint(),
        expect: () => [
          const SignInState(
            pin: '',
            canCheckBiometrics: null,
            status: SignInStatus.failure,
          ),
        ],
      );
    },
  );

  group(
    'signInUser',
    () {
      blocTest<SignInCubit, SignInState>(
        'emits success when signInUser is success',
        build: () {
          when(() => repositoryMock.signInUser('1234')).thenAnswer(
            (_) async => true,
          );
          return SignInCubit(
            localAuthentication: localAuthenticationMock,
            userPinBox: userPinBoxMock,
            repository: repositoryMock,
          );
        },
        act: (cubit) => cubit.signInUser('1234'),
        expect: () => [
          const SignInState(
            pin: '',
            canCheckBiometrics: null,
            status: SignInStatus.success,
          ),
        ],
      );

      blocTest<SignInCubit, SignInState>(
        'emits failure when signInUser is not success',
        build: () {
          when(() => repositoryMock.signInUser('1234')).thenAnswer(
            (_) async => false,
          );
          return SignInCubit(
            localAuthentication: localAuthenticationMock,
            userPinBox: userPinBoxMock,
            repository: repositoryMock,
          );
        },
        act: (cubit) => cubit.signInUser('1234'),
        expect: () => [
          const SignInState(
            pin: '',
            canCheckBiometrics: null,
            status: SignInStatus.failure,
          ),
        ],
      );
    },
  );
}
