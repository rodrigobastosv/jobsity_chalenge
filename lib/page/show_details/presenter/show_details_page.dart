import 'package:flutter/material.dart';
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(state.show.originalImage!),
              if (state.status == ShowDetailsStatus.success)
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (_, i) => ListTile(
                    onTap: () => Navigator.of(context).pushNamed(
                      episodeDetailsPage,
                      arguments: state.episodes[i],
                    ),
                    title: Text(state.episodes[i].name!),
                  ),
                  itemCount: state.episodes.length,
                )
              else
                const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
