import 'package:flutter/material.dart';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../core/data/model/show_episode_model.dart';

class EpisodeDetailsPage extends StatelessWidget {
  const EpisodeDetailsPage(
    this.episode, {
    Key? key,
  }) : super(key: key);

  final ShowEpisodeModel episode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Hero(
            tag: 'episode_${episode.id}',
            child: FancyShimmerImage(
              imageUrl: episode.originalImage!,
            ),
          ),
          Text(
            '${episode.name!} (Season ${episode.season} Episode ${episode.number})',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          if (episode.rating != null)
            Center(
              child: RatingBar.builder(
                initialRating: episode.rating!,
                minRating: 0,
                maxRating: 10,
                direction: Axis.horizontal,
                itemSize: 24,
                allowHalfRating: true,
                itemCount: 10,
                itemPadding: const EdgeInsets.symmetric(horizontal: 2),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {},
              ),
            ),
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Airdate: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: '${episode.airdate} at ${episode.airtime}',
                        style: const TextStyle(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Runtime: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: '${episode.runtime} minutes',
                        style: const TextStyle(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  episode.summary!.replaceAll('<p>', '').replaceAll(
                        '</p>',
                        '',
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
