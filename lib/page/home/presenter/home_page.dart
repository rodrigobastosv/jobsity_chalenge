import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_chalenge/page/home/data/repository/home_repository.dart';
import 'package:jobsity_chalenge/page/page.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(
        repository: context.read<HomeRepository>(),
      )..fetchShows(page: 0),
      child: const HomeView(),
    );
  }
}
