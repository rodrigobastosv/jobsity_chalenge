import 'package:expandable_fab_menu/expandable_fab_menu.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:jobsity_chalenge/page/home/presenter/widget/widget.dart';
import '../../../../utils.dart';

void main() {
  testWidgets(
    'should show ExpandableFabMenu',
    (tester) async {
      await pumpWidgetWithApp(
        tester,
        widget: HomeMenu(),
      );

      final menuButton = find.byType(ExpandableFabMenu);
      await tester.tap(menuButton);
      await tester.pumpAndSettle();
      await tester.pump();

      expect(find.byType(ExpandableFabMenu), findsOneWidget);
    },
  );
}
