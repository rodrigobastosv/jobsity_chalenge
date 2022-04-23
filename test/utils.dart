import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';

Future<void> pumpWidgetWithApp(
  WidgetTester tester, {
  required Widget widget,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: widget,
      ),
    ),
  );
}

Future<void> pumpWidgetWithAppNavigation(
  WidgetTester tester,
  MockNavigator mockNavigator, {
  required Widget widget,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: MockNavigatorProvider(
        navigator: mockNavigator,
        child: Scaffold(
          body: widget,
        ),
      ),
    ),
  );
}
