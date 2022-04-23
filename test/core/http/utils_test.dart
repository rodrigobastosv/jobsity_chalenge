import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:jobsity_chalenge/core/core.dart';

void main() {
  test(
    'getDefaultClient returns a Dio instance',
    () {
      final client = getDefaultClient();
      expect(client, isA<Dio>());
    },
  );
}
