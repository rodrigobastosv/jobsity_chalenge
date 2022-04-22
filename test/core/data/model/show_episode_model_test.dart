import 'package:flutter_test/flutter_test.dart';
import 'package:jobsity_chalenge/core/data/model/show_episode_model.dart';

void main() {
  final showEpisodeJsonMock = {
    "id": 1,
    "url": "https://www.tvmaze.com/episodes/1/under-the-dome-1x01-pilot",
    "name": "Pilot",
    "season": 1,
    "number": 1,
    "type": "regular",
    "airdate": "2013-06-24",
    "airtime": "22:00",
    "runtime": 60,
    "rating": {"average": 7.7},
    "image": {
      "medium":
          "https://static.tvmaze.com/uploads/images/medium_landscape/1/4388.jpg",
      "original":
          "https://static.tvmaze.com/uploads/images/original_untouched/1/4388.jpg"
    },
    "summary":
        "<p>When the residents of Chester's Mill find themselves trapped under a massive transparent dome with no way out, they struggle to survive as resources rapidly dwindle and panic quickly escalates.</p>",
  };

  test(
    'fromJson',
    () {
      final showEpisode = ShowEpisodeModel.fromJson(showEpisodeJsonMock);
      expect(showEpisode, isA<ShowEpisodeModel>());
    },
  );

  test(
    'toJson',
    () {
      final showEpisode = ShowEpisodeModel.fromJson(showEpisodeJsonMock);
      expect(showEpisode.toJson(), showEpisodeJsonMock);
    },
  );

  test(
    'props',
    () {
      final showEpisode1 = ShowEpisodeModel.fromJson(showEpisodeJsonMock);
      final showEpisode2 = ShowEpisodeModel.fromJson(showEpisodeJsonMock);
      expect(showEpisode1 == showEpisode2, true);
    },
  );
}
