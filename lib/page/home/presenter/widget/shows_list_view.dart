import 'package:flutter/material.dart';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_infinite_list/very_good_infinite_list.dart';

import '../../../../core/core.dart';
import '../../../../core/data/model/show_model.dart';
import '../../home.dart';
import '../cubit/home_state.dart';
import 'empty_show_list.dart';

class ShowsListView extends StatelessWidget {
  const ShowsListView(
    this.shows, {
    Key? key,
  }) : super(key: key);

  final List<ShowModel> shows;

  @override
  Widget build(BuildContext context) {
    return InfiniteList(
      itemCount: shows.length,
      isLoading: context.watch<HomeCubit>().state.status == HomeStatus.loading,
      onFetchData: context.read<HomeCubit>().fetchShowsByPage,
      emptyBuilder: (_) => EmptyShowList(),
      loadingBuilder: (_) => const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      itemBuilder: (_, i) => InkWell(
        onTap: () => Navigator.of(context).pushNamed(
          showDetailsPage,
          arguments: shows[i],
        ),
        child: Card(
          color: Colors.grey[200],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (shows[i].originalImage != null)
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  child: Hero(
                    tag: shows[i].id,
                    child: FancyShimmerImage(
                      imageUrl: shows[i].originalImage!,
                      boxFit: BoxFit.cover,
                    ),
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
      separatorBuilder: (_) => const SizedBox(height: 8),
    );
  }
}
