import 'package:flutter_test/flutter_test.dart';

import 'package:jobsity_chalenge/page/favorite_shows/presenter/cubit/favorite_shows_state.dart';

void main() {
  test(
    'copyWith',
    () {
      final state1 = FavoriteShowsState.initial();
      final state2 = state1.copyWith();
      final state3 = state1.copyWith(
        status: FavoriteShowsStatus.success,
      );

      expect(state1 == state2, true);
      expect(state1 == state3, false);
    },
  );
}
