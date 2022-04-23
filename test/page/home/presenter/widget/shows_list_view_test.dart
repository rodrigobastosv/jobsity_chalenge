import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';

import 'package:jobsity_chalenge/core/core.dart';
import 'package:jobsity_chalenge/page/home/presenter/widget/widget.dart';
import '../../../../data.dart';
import '../../../../utils.dart';

void main() {
  testWidgets(
    'should navigate to showDetailsPage when press on show card',
    (tester) async {
      final mockNavigator = MockNavigator();
      when(
        () => mockNavigator.pushNamed(
          any(),
          arguments: any(named: 'arguments'),
        ),
      ).thenAnswer((_) async => {});

      await pumpWidgetWithAppNavigation(
        tester,
        mockNavigator,
        widget: const ShowsListView(
          [
            showFake,
            showFake,
          ],
        ),
      );

      final card = find.byType(Card).first;
      await tester.tap(card);
      await tester.pump();

      verify(
        () => mockNavigator.pushNamed(
          showDetailsPage,
          arguments: showFake,
        ),
      ).called(1);
    },
  );
}
