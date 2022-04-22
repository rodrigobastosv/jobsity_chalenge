import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:jobsity_chalenge/core/data/model/show_model.dart';

import '../../../../core/core.dart';

class ShowsListView extends StatelessWidget {
  const ShowsListView(
    this.shows, {
    Key? key,
  }) : super(key: key);

  final List<ShowModel> shows;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (_, i) => InkWell(
        onTap: () => Navigator.of(context).pushNamed(
          showDetailsPage,
          arguments: shows[i],
        ),
        child: Card(
          color: Colors.grey[300],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (shows[i].originalImage != null)
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  child: FancyShimmerImage(
                    imageUrl: shows[i].originalImage!,
                    boxFit: BoxFit.cover,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text(
                  shows[i].name ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      separatorBuilder: (_, i) => const SizedBox(height: 8),
      itemCount: shows.length,
    );
  }
}
