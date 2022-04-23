import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../home.dart';
import 'widget/widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeCubit = context.watch<HomeCubit>();
    final state = homeCubit.state;

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
        child: ShowsListView(state.shows),
      ),
      floatingActionButton: HomeMenu(),
    );
  }
}
