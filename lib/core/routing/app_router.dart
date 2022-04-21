import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_chalenge/core/data/model/show_episode_model.dart';
import 'package:jobsity_chalenge/core/data/model/show_model.dart';
import 'package:jobsity_chalenge/core/routing/routes.dart';
import 'package:jobsity_chalenge/page/episode_details/episode_details.dart';
import 'package:jobsity_chalenge/page/favorite_shows/favorite_shows.dart';
import 'package:jobsity_chalenge/page/home/home.dart';
import 'package:jobsity_chalenge/page/people_search/people_search.dart';
import 'package:jobsity_chalenge/page/person_details/person_details.dart';
import 'package:jobsity_chalenge/page/show_details/show_details.dart';

import '../../page/home/data/repository/home_repository.dart';

class AppRouter {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    final args = settings.arguments;
    final routeName = settings.name;

    late Widget routeWidget;
    if (routeName == homePage) {
      routeWidget = BlocProvider<HomeCubit>(
        create: (context) => HomeCubit(
          repository: context.read<HomeRepository>(),
        )..fetchShowsByPage(0),
        child: const HomePage(),
      );
    } else if (routeName == showDetailsPage) {
      routeWidget = BlocProvider<ShowDetailsCubit>(
        create: (context) => ShowDetailsCubit(
          show: args! as ShowModel,
          showDetailsRepository: context.read<ShowDetailsRepository>(),
          showFavoriteInfoRepository:
              context.read<ShowFavoriteInfoRepository>(),
        )
          ..loadFavoritedInfo()
          ..fetchShowEpisodes(),
        child: const ShowDetailsPage(),
      );
    } else if (routeName == episodeDetailsPage) {
      final episode = args! as ShowEpisodeModel;
      routeWidget = EpisodeDetailsPage(episode);
    } else if (routeName == favoritesShowsPage) {
      routeWidget = BlocProvider<FavoriteShowsCubit>(
        create: (context) => FavoriteShowsCubit(
          repository: context.read<FavoriteShowsRepository>(),
        )..fetchFavoriteShows(),
        child: const FavoriteShowsPage(),
      );
    } else if (routeName == peopleSearchPage) {
      routeWidget = BlocProvider<PeopleSearchCubit>(
        create: (context) => PeopleSearchCubit(
          repository: context.read<PeopleSearchRepository>(),
        )..fetchPeople(),
        child: const PeopleSearchPage(),
      );
    } else if (routeName == personDetailsPage) {
      routeWidget = BlocProvider<PersonDetailsCubit>(
        create: (context) => PersonDetailsCubit(
          person: args! as PersonModel,
          repository: context.read<PersonDetailsRepository>(),
        )..fetchShows(),
        child: const PersonDetailsPage(),
      );
    } else {
      routeWidget = const Scaffold();
    }

    return MaterialPageRoute(
      builder: (_) => routeWidget,
      settings: settings,
    );
  }
}
