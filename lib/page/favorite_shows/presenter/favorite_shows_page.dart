import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
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
      builder: (_, state) => SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Favorite Shows',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 18),
                  state.status == FavoriteShowsStatus.loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemBuilder: (_, i) => GestureDetector(
                            onTap: () => Navigator.of(context).pushNamed(
                              showDetailsPage,
                              arguments: state.shows[i],
                            ),
                            child: FancyShimmerImage(
                              imageUrl: state.shows[i].originalImage!,
                            ),
                          ),
                          itemCount: state.shows.length,
                        ),
                      )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
