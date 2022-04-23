import 'package:flutter_test/flutter_test.dart';
import 'package:jobsity_chalenge/page/sign_up/presenter/cubit/sign_up_state.dart';

void main() {
  test(
    'copyWith',
    () {
      final state1 = SignUpState.initial();
      final state2 = state1.copyWith();
      final state3 = state1.copyWith(
        status: SignUpStatus.success,
      );

      expect(state1 == state2, true);
      expect(state1 == state3, false);
    },
  );
}
