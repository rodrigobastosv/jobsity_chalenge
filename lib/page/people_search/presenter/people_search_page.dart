import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_chalenge/page/people_search/people_search.dart';

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
              //initialValue: state.query,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Search people...',
              ),
              //onChanged: context.read<HomeCubit>().onChangeQuery,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {},
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
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(state.people[i].mediumImage!),
                  ),
                  title: Text(state.people[i].name!),
                ),
                itemCount: state.people.length,
              ),
      ),
    );
  }
}
