import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_chalenge/page/person_details/person_details.dart';

import '../../../core/core.dart';
import 'cubit/person_details_state.dart';

class PersonDetailsPage extends StatelessWidget {
  const PersonDetailsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final person = context.read<PersonDetailsCubit>().state.person;
    return Scaffold(
      body: Column(
        children: [
          person.mediumImage != null
              ? CircleAvatar(
                  backgroundImage: NetworkImage(person.mediumImage!),
                )
              : const Icon(Icons.person),
          Text(person.name!),
          BlocBuilder<PersonDetailsCubit, PersonDetailsState>(
            builder: (_, state) {
              if (state.status == PersonDetailsStatus.failure) {
                return Text(state.errorMessage);
              } else if (state.status == PersonDetailsStatus.success) {
                if (state.shows.isEmpty) {
                  return const Text('No information was returned');
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (_, i) => ListTile(
                    onTap: () => Navigator.of(context).pushNamed(
                      showDetailsPage,
                      arguments: state.shows[i],
                    ),
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(state.shows[i].mediumImage!),
                    ),
                    title: Text(state.shows[i].name!),
                  ),
                  itemCount: state.shows.length,
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          )
        ],
      ),
    );
  }
}
