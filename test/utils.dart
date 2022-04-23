import 'package:flutter/gestures.dart';
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

bool findTextAndTap(InlineSpan visitor, String text) {
  if (visitor is TextSpan && visitor.text == text) {
    (visitor.recognizer as TapGestureRecognizer).onTap!();

    return false;
  }

  return true;
}

bool tapTextSpan(RichText richText, String text) {
  final isTapped = !richText.text.visitChildren(
    (visitor) => findTextAndTap(visitor, text),
  );

  return isTapped;
}
