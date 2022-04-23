import 'package:flutter/material.dart';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:jobsity_chalenge/core/core.dart';
import 'package:jobsity_chalenge/page/show_details/show_details.dart';
import 'cubit/show_details_state.dart';

class ShowDetailsPage extends StatelessWidget {
  const ShowDetailsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowDetailsCubit, ShowDetailsState>(
      builder: (_, state) => Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              fit: StackFit.passthrough,
              children: [
                Hero(
                  tag: state.show.id,
                  child: FancyShimmerImage(
                    imageUrl: state.show.originalImage!,
                    boxFit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () =>
                        context.read<ShowDetailsCubit>().toggleFavoriteShow(),
                    child: Icon(
                      state.isShowFavorited!
                          ? Icons.favorite
                          : Icons.favorite_border,
                      key: const ValueKey('favorite_icon_key'),
                      color: Theme.of(context).colorScheme.primary,
                      size: 32,
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Episodes',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
            ),
            if (state.status == ShowDetailsStatus.success)
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(top: 0),
                  shrinkWrap: true,
                  itemBuilder: (_, i) {
                    final episode = state.episodes[i];
                    return ListTile(
                      onTap: () => Navigator.of(context).pushNamed(
                        episodeDetailsPage,
                        arguments: episode,
                      ),
                      leading: Hero(
                        tag: 'episode_${episode.id}',
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(episode.mediumImage!),
                        ),
                      ),
                      title: Text(
                          '${episode.name!} (Season ${episode.season} Episode ${episode.number})'),
                    );
                  },
                  separatorBuilder: (_, i) => const Divider(),
                  itemCount: state.episodes.length,
                ),
              )
            else
              const Center(
                child: SizedBox(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
