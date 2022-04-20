import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_chalenge/core/core.dart';
import 'package:jobsity_chalenge/page/home/home.dart';

import 'cubit/home_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (_, state) {
        if (state.status == HomeStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status == HomeStatus.failure) {
          return Center(
            child: Text(state.errorMessage),
          );
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[200],
            toolbarHeight: 80,
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: state.query,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Search shows...',
                ),
                onChanged: context.read<HomeCubit>().onChangeQuery,
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () => context.read<HomeCubit>().fetchShowsByQuery(),
                child: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (_, i) => InkWell(
                onTap: () => Navigator.of(context).pushNamed(
                  showDetailsPage,
                  arguments: state.shows[i],
                ),
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (state.shows[i].originalImage != null)
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                          child: Image.network(
                            state.shows[i].originalImage!,
                          ),
                        ),
                      Text(state.shows[i].name ?? ''),
                    ],
                  ),
                ),
              ),
              separatorBuilder: (_, i) => const SizedBox(height: 8),
              itemCount: state.shows.length,
            ),
          ),
        );
      },
    );
  }
}
