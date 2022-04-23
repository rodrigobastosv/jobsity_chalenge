import 'package:flutter_test/flutter_test.dart';

import 'package:jobsity_chalenge/page/sign_in/presenter/cubit/sign_in_state.dart';

void main() {
  test(
    'copyWith',
    () {
      final state1 = SignInState.initial();
      final state2 = state1.copyWith();
      final state3 = state1.copyWith(
        status: SignInStatus.success,
      );

      expect(state1 == state2, true);
      expect(state1 == state3, false);
    },
  );
}
