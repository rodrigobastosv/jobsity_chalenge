import 'package:flutter_test/flutter_test.dart';

import 'package:jobsity_chalenge/core/data/model/show_episode_model.dart';
import 'package:jobsity_chalenge/page/episode_details/episode_details.dart';
import '../../utils.dart';

void main() {
  testWidgets(
    'should build without exploding',
    (tester) async {
      await pumpWidgetWithApp(
        tester,
        widget: const EpisodeDetailsPage(
          ShowEpisodeModel(
            id: 1,
            name: 'Episode name',
            originalImage: 'ímage',
            summary: 'summary',
          ),
        ),
      );

      expect(find.byType(EpisodeDetailsPage), findsOneWidget);
    },
  );

  testWidgets(
    'should show rating bar if episode has rating',
    (tester) async {
      await pumpWidgetWithApp(
        tester,
        widget: const EpisodeDetailsPage(
          ShowEpisodeModel(
            id: 1,
            name: 'Episode name',
            originalImage: 'ímage',
            summary: 'summary',
            rating: 8,
          ),
        ),
      );

      expect(find.byType(EpisodeDetailsPage), findsOneWidget);
    },
  );
}
