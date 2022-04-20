import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_chalenge/page/home/data/repository/http_home_repository.dart';

import 'page/home/data/repository/home_repository.dart';

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
      ],
      child: child,
    );
  }
}
