import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jobsity_chalenge/page/sign_up/presenter/cubit/sign_up_state.dart';
import 'package:jobsity_chalenge/page/sign_up/sign_up.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mock.dart';

void main() {
  late SignUpRepositoryMock repositoryMock;

  setUp(
    () {
      repositoryMock = SignUpRepositoryMock();
    },
  );

  test(
    'initial state is SignUpState.initial()',
    () {
      final cubit = SignUpCubit(
        repository: repositoryMock,
      );
      expect(cubit.state, SignUpState.initial());
    },
  );

  group(
    'signUpUser',
    () {
      blocTest<SignUpCubit, SignUpState>(
        'emits success when signInUser is success',
        build: () {
          when(() => repositoryMock.signUpUser('1234')).thenAnswer(
            (_) async => true,
          );
          return SignUpCubit(
            repository: repositoryMock,
          );
        },
        act: (cubit) => cubit.signUpUser('1234'),
        expect: () => [
          const SignUpState(
            status: SignUpStatus.success,
          ),
        ],
      );

      blocTest<SignUpCubit, SignUpState>(
        'emits failure when signInUser is not success',
        build: () {
          when(() => repositoryMock.signUpUser('1234')).thenThrow(Exception());
          return SignUpCubit(
            repository: repositoryMock,
          );
        },
        act: (cubit) => cubit.signUpUser('1234'),
        expect: () => [
          const SignUpState(
            status: SignUpStatus.failure,
          ),
        ],
      );
    },
  );
}
