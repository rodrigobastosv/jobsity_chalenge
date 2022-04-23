import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

import '../../page/episode_details/episode_details.dart';
import '../../page/favorite_shows/favorite_shows.dart';
import '../../page/home/data/repository/home_repository.dart';
import '../../page/home/home.dart';
import '../../page/people_search/people_search.dart';
import '../../page/person_details/person_details.dart';
import '../../page/show_details/show_details.dart';
import '../../page/sign_in/sign_in.dart';
import '../../page/sign_up/sign_up.dart';
import '../core.dart';
import '../data/model/show_episode_model.dart';
import '../data/model/show_model.dart';

class AppRouter {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    final args = settings.arguments;
    final routeName = settings.name;

    late Widget routeWidget;
    if (routeName == signInPage) {
      routeWidget = BlocProvider<SignInCubit>(
        create: (context) => SignInCubit(
          localAuthentication: LocalAuthentication(),
          userPinBox: userPinBox,
          repository: context.read<SignInRepository>(),
        )..checkForBioSupport(),
        child: SignInPage(),
      );
    } else if (routeName == signUpPage) {
      routeWidget = BlocProvider<SignUpCubit>(
        create: (context) => SignUpCubit(
          repository: context.read<SignUpRepository>(),
        ),
        child: SignUpPage(),
      );
    } else if (routeName == homePage) {
      routeWidget = BlocProvider<HomeCubit>(
        create: (context) => HomeCubit(
          repository: context.read<HomeRepository>(),
        )..fetchShowsByPage(0),
        child: HomePage(),
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
        child: ShowDetailsPage(),
      );
    } else if (routeName == episodeDetailsPage) {
      final episode = args! as ShowEpisodeModel;
      routeWidget = EpisodeDetailsPage(episode);
    } else if (routeName == favoritesShowsPage) {
      routeWidget = BlocProvider<FavoriteShowsCubit>(
        create: (context) => FavoriteShowsCubit(
          repository: context.read<FavoriteShowsRepository>(),
        )..fetchFavoriteShows(),
        child: FavoriteShowsPage(),
      );
    } else if (routeName == peopleSearchPage) {
      routeWidget = BlocProvider<PeopleSearchCubit>(
        create: (context) => PeopleSearchCubit(
          repository: context.read<PeopleSearchRepository>(),
        )..fetchPeople(),
        child: PeopleSearchPage(),
      );
    } else if (routeName == personDetailsPage) {
      routeWidget = BlocProvider<PersonDetailsCubit>(
        create: (context) => PersonDetailsCubit(
          person: args! as PersonModel,
          repository: context.read<PersonDetailsRepository>(),
        )..fetchShows(),
        child: PersonDetailsPage(),
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
