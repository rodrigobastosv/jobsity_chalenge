import 'package:flutter/material.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';

import 'package:jobsity_chalenge/core/core.dart';
import 'package:jobsity_chalenge/page/sign_in/presenter/cubit/sign_in_state.dart';
import 'package:jobsity_chalenge/page/sign_in/presenter/presenter.dart';
import '../../../mock.dart';
import '../../../utils.dart';

void main() {
  late SignInCubitMock signInCubitMock;

  setUp(
    () {
      signInCubitMock = SignInCubitMock();
    },
  );

  testWidgets(
    'should build without exploding',
    (tester) async {
      when(() => signInCubitMock.state).thenReturn(SignInState.initial());

      await pumpWidgetWithApp(
        tester,
        widget: BlocProvider<SignInCubit>.value(
          value: signInCubitMock,
          child: SignInPage(),
        ),
      );

      expect(find.byType(SignInPage), findsOneWidget);
    },
  );

  testWidgets(
    'should show loading if status is loading',
    (tester) async {
      when(() => signInCubitMock.state).thenReturn(
        SignInState.initial().copyWith(
          status: SignInStatus.loading,
        ),
      );

      await pumpWidgetWithApp(
        tester,
        widget: BlocProvider<SignInCubit>.value(
          value: signInCubitMock,
          child: SignInPage(),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'should call authWithFingeprint from cubit when press button',
    (tester) async {
      when(() => signInCubitMock.state).thenReturn(
        SignInState.initial().copyWith(
          status: SignInStatus.initial,
          canCheckBiometrics: true,
        ),
      );
      when(() => signInCubitMock.authWithFingeprint())
          .thenAnswer((_) async => {});

      await pumpWidgetWithApp(
        tester,
        widget: BlocProvider<SignInCubit>.value(
          value: signInCubitMock,
          child: SignInPage(),
        ),
      );

      final fingerprintButton =
          find.byKey(const ValueKey('fingerprint_button_key'));
      await tester.tap(fingerprintButton);
      verify(() => signInCubitMock.authWithFingeprint()).called(1);
    },
  );

  testWidgets(
    'should navigate to homePage when press option',
    (tester) async {
      whenListen(
        signInCubitMock,
        Stream.fromIterable(
          [
            SignInState.initial().copyWith(
              status: SignInStatus.success,
              canCheckBiometrics: true,
            ),
          ],
        ),
        initialState: SignInState.initial().copyWith(
          status: SignInStatus.initial,
          canCheckBiometrics: true,
        ),
      );

      final mockNavigator = MockNavigator();
      when(
        () => mockNavigator.pushReplacementNamed(
          any(),
        ),
      ).thenAnswer((_) async => {});

      await pumpWidgetWithAppNavigation(
        tester,
        mockNavigator,
        widget: BlocProvider<SignInCubit>.value(
          value: signInCubitMock,
          child: SignInPage(),
        ),
      );

      verify(
        () => mockNavigator.pushReplacementNamed(
          homePage,
        ),
      ).called(1);
    },
  );

  testWidgets(
    'should show error when failure',
    (tester) async {
      await tester.runAsync(
        () async {
          whenListen(
            signInCubitMock,
            Stream.fromIterable(
              [
                SignInState.initial().copyWith(
                  status: SignInStatus.failure,
                  canCheckBiometrics: true,
                ),
              ],
            ),
            initialState: SignInState.initial().copyWith(
              status: SignInStatus.initial,
              canCheckBiometrics: true,
            ),
          );

          await pumpWidgetWithApp(
            tester,
            widget: BlocProvider<SignInCubit>.value(
              value: signInCubitMock,
              child: SignInPage(),
            ),
          );
          await tester.pump();
          expect(find.text('Incorrect PIN'), findsOneWidget);
        },
      );
    },
  );

  testWidgets(
    'should navigate to signUpPage when press option',
    (tester) async {
      when(() => signInCubitMock.state).thenReturn(
        SignInState.initial().copyWith(
          status: SignInStatus.initial,
          canCheckBiometrics: true,
        ),
      );
      final mockNavigator = MockNavigator();
      when(
        () => mockNavigator.pushNamed(
          any(),
        ),
      ).thenAnswer((_) async => {});

      await pumpWidgetWithAppNavigation(
        tester,
        mockNavigator,
        widget: BlocProvider<SignInCubit>.value(
          value: signInCubitMock,
          child: SignInPage(),
        ),
      );

      final register = find.byWidgetPredicate(
        (widget) => widget is RichText && tapTextSpan(widget, 'Register!'),
      );
      await tester.tap(register);

      verify(
        () => mockNavigator.pushNamed(
          signUpPage,
        ),
      ).called(1);
    },
  );
}
