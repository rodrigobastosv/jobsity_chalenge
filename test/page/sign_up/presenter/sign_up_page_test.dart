import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';

import 'package:jobsity_chalenge/page/sign_up/presenter/cubit/sign_up_state.dart';
import 'package:jobsity_chalenge/page/sign_up/sign_up.dart';
import '../../../mock.dart';
import '../../../utils.dart';

void main() {
  late SignUpCubitMock signUpCubitMock;

  setUp(
    () {
      signUpCubitMock = SignUpCubitMock();
    },
  );

  testWidgets(
    'should build without exploding',
    (tester) async {
      when(() => signUpCubitMock.state).thenReturn(SignUpState.initial());

      await pumpWidgetWithApp(
        tester,
        widget: BlocProvider<SignUpCubit>.value(
          value: signUpCubitMock,
          child: SignUpPage(),
        ),
      );

      expect(find.byType(SignUpPage), findsOneWidget);
    },
  );

  testWidgets(
    'should show success notification',
    (tester) async {
      await tester.runAsync(
        () async {
          when(() => signUpCubitMock.state).thenReturn(SignUpState.initial());
          whenListen(
            signUpCubitMock,
            Stream.fromIterable(
              [
                SignUpState.initial().copyWith(
                  status: SignUpStatus.success,
                ),
              ],
            ),
            initialState: SignUpState.initial(),
          );

          await pumpWidgetWithApp(
            tester,
            widget: BlocProvider<SignUpCubit>.value(
              value: signUpCubitMock,
              child: SignUpPage(),
            ),
          );
        },
      );
    },
  );
}
