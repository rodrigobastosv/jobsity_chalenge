import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_chalenge/page/people_search/people_search.dart';

import '../../../core/core.dart';
import 'cubit/people_search_state.dart';

class PeopleSearchPage extends StatelessWidget {
  const PeopleSearchPage({
    Key? key,
  }) : super(key: key);

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
        body: state.status == PeopleSearchStatus.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
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
                itemCount: state.people.length,
              ),
      ),
    );
  }
}
