import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:jobsity_chalenge/page/sign_up/data/data.dart';
import '../../../../mock.dart';

void main() {
  late HiveSignUpRepository repository;
  late BoxMock boxMock;

  setUp(
    () {
      boxMock = BoxMock();
      repository = HiveSignUpRepository(boxMock);
    },
  );

  group(
    'signUpUser',
    () {
      test(
        'should sign up success',
        () async {
          when(() => boxMock.get(any())).thenReturn([
            '1234',
          ]);
          when(() => boxMock.put(any(), any())).thenAnswer((_) async => {});
          await repository.signUpUser('1234');
        },
      );
    },
  );
}
