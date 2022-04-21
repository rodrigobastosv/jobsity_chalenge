import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_chalenge/page/favorite_shows/favorite_shows.dart';

import '../../../core/core.dart';
import 'cubit/favorite_shows_state.dart';
import 'presenter.dart';

class FavoriteShowsPage extends StatelessWidget {
  const FavoriteShowsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteShowsCubit, FavoriteShowsState>(
      builder: (_, state) => Scaffold(
        body: state.status == FavoriteShowsStatus.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemBuilder: (_, i) => ListTile(
                  onTap: () => Navigator.of(context).pushNamed(
                    showDetailsPage,
                    arguments: state.shows[i],
                  ),
                  title: Text(state.shows[i].name!),
                  trailing: IconButton(
                    onPressed: () => context
                        .read<FavoriteShowsCubit>()
                        .deleteFavoriteShow(state.shows[i].id),
                    icon: const Icon(
                      Icons.delete_forever,
                    ),
                  ),
                ),
                itemCount: state.shows.length,
              ),
      ),
    );
  }
}
