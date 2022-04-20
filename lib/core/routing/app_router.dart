import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_chalenge/core/data/model/show_episode_model.dart';
import 'package:jobsity_chalenge/core/data/model/show_model.dart';
import 'package:jobsity_chalenge/core/routing/routes.dart';
import 'package:jobsity_chalenge/page/episode_details/episode_details.dart';
import 'package:jobsity_chalenge/page/home/home.dart';
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
          repository: context.read<ShowDetailsRepository>(),
        )..fetchShowEpisodes(),
        child: const ShowDetailsPage(),
      );
    } else if (routeName == episodeDetailsPage) {
      final episode = args! as ShowEpisodeModel;
      routeWidget = EpisodeDetailsPage(episode);
    } else {
      routeWidget = const Scaffold();
    }

    return MaterialPageRoute(
      builder: (_) => routeWidget,
      settings: settings,
    );
  }
}
