import 'package:flutter_test/flutter_test.dart';
import 'package:jobsity_chalenge/page/sign_in/sign_in.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mock.dart';

void main() {
  late HiveSignInRepository repository;
  late BoxMock boxMock;

  setUp(
    () {
      boxMock = BoxMock();
      repository = HiveSignInRepository(boxMock);
    },
  );

  group(
    'signInUser',
    () {
      test(
        'should sign in success',
        () async {
          when(() => boxMock.get(any())).thenReturn([
            '1234',
          ]);
          when(() => boxMock.put(any(), any())).thenAnswer((_) async => {});

          final isSignInSuccess = await repository.signInUser('1234');
          expect(isSignInSuccess, true);
        },
      );

      test(
        'should sign in failed',
        () async {
          when(() => boxMock.get(any())).thenReturn([
            '123',
          ]);
          when(() => boxMock.put(any(), any())).thenAnswer((_) async => {});

          final isSignInSuccess = await repository.signInUser('1234');
          expect(isSignInSuccess, false);
        },
      );
    },
  );
}
