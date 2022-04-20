import 'package:flutter/material.dart';
import 'package:jobsity_chalenge/core/data/model/show_episode_model.dart';

class EpisodeDetailsPage extends StatelessWidget {
  const EpisodeDetailsPage(this.episode, {
    Key? key,
  }) : super(key: key);

  final ShowEpisodeModel episode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(episode.name!),
      ),
    );
  }
}
