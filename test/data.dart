import 'package:jobsity_chalenge/core/data/model/show_episode_model.dart';
import 'package:jobsity_chalenge/core/data/model/show_model.dart';
import 'package:jobsity_chalenge/page/people_search/data/data.dart';

const showFake = ShowModel(
  id: 1,
  averageRuntime: 200,
  ended: '',
  genres: ['action'],
  language: 'English',
  mediumImage: 'image',
  name: 'Name',
  officialSite: 'Site',
  originalImage: 'image',
  rating: 8,
  runtime: 200,
  scheduleDays: [],
);

const personFake = PersonModel(
  id: 1,
  country: 'USA',
  gender: 'Male',
  name: 'Mike',
  mediumImage: 'image',
  originalImage: 'image',
);

const episodeFake = ShowEpisodeModel(
  id: 1,
  mediumImage: 'image',
  name: 'name',
  rating: 7,
  summary: 'summary',
  number: 1,
  season: 1,
  originalImage: 'image,'
);
