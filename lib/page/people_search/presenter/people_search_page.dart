import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_infinite_list/very_good_infinite_list.dart';

import '../../../core/core.dart';
import '../people_search.dart';
import 'cubit/people_search_state.dart';

class PeopleSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PeopleSearchCubit, PeopleSearchState>(
      builder: (_, state) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey[200],
          toolbarHeight: 80,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: state.query,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Search people...',
              ),
              onChanged: context.read<PeopleSearchCubit>().onChangeQuery,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () =>
                  context.read<PeopleSearchCubit>().fetchPeopleByQuery(),
              child: const Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: InfiniteList(
          itemCount: state.people.length,
          isLoading: context.watch<PeopleSearchCubit>().state.status ==
              PeopleSearchStatus.loading,
          onFetchData: context.read<PeopleSearchCubit>().fetchPeople,
          emptyBuilder: (_) => const Center(
            child: Text(
              'No person found!',
            ),
          ),
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
          itemBuilder: (_, i) => ListTile(
            onTap: () => Navigator.of(context).pushNamed(
              personDetailsPage,
              arguments: state.people[i],
            ),
            leading: state.people[i].mediumImage != null
                ? Hero(
                    tag: 'person_${state.people[i]}',
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage(state.people[i].mediumImage!),
                    ),
                  )
                : const Icon(Icons.person),
            title: Text(state.people[i].name!),
          ),
          separatorBuilder: (_) => const SizedBox(height: 8),
        ),
      ),
    );
  }
}
