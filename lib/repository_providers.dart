import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_chalenge/core/core.dart';
import 'package:jobsity_chalenge/page/home/data/repository/http_home_repository.dart';
import 'package:jobsity_chalenge/page/people_search/data/data.dart';
import 'package:jobsity_chalenge/page/person_details/person_details.dart';
import 'package:jobsity_chalenge/page/sign_in/sign_in.dart';

import 'page/favorite_shows/data/repository/repository.dart';
import 'page/home/data/repository/home_repository.dart';
import 'page/show_details/data/data.dart';
import 'page/sign_up/data/data.dart';

class RepositoryProviders extends StatelessWidget {
  const RepositoryProviders({
    Key? key,
    required this.client,
    required this.child,
  }) : super(key: key);

  final Dio client;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<HomeRepository>(
          create: (_) => HttpHomeRepository(client),
        ),
        RepositoryProvider<ShowDetailsRepository>(
          create: (_) => HttpShowDetailsRepository(client),
        ),
        RepositoryProvider<PeopleSearchRepository>(
          create: (_) => HttpPeopleSearchRepository(client),
        ),
        RepositoryProvider<PersonDetailsRepository>(
          create: (_) => HttpPersonDetailsRepository(client),
        ),
        RepositoryProvider<ShowFavoriteInfoRepository>(
          create: (_) => HiveShowFavoriteInfoRepository(
            userPinBox: userPinBox,
            favoriteMoviesBox: favoriteMoviesBox,
          ),
        ),
        RepositoryProvider<FavoriteShowsRepository>(
          create: (_) => HiveFavoriteShowsRepository(
            userPinBox: userPinBox,
            favoriteMoviesBox: favoriteMoviesBox,
          ),
        ),
        RepositoryProvider<SignInRepository>(
          create: (_) => HiveSignInRepository(userPinBox),
        ),
        RepositoryProvider<SignUpRepository>(
          create: (_) => HiveSignUpRepository(userPinBox),
        ),
      ],
      child: child,
    );
  }
}
