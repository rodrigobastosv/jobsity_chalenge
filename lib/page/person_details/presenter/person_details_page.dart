import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../core/core.dart';
import '../person_details.dart';
import 'cubit/person_details_state.dart';

class PersonDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final person = context.read<PersonDetailsCubit>().state.person;
    return Scaffold(
      appBar: AppBar(
        title: Text(person.name!),
      ),
      body: BlocBuilder<PersonDetailsCubit, PersonDetailsState>(
        builder: (_, state) {
          if (state.status == PersonDetailsStatus.failure) {
            return Text(state.errorMessage);
          } else if (state.status == PersonDetailsStatus.success) {
            if (state.shows.isEmpty) {
              return Center(
                child: Lottie.asset(
                  'assets/no-info-show.json',
                  repeat: false,
                ),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 0),
              itemBuilder: (_, i) => ListTile(
                onTap: () => Navigator.of(context).pushNamed(
                  showDetailsPage,
                  arguments: state.shows[i],
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(state.shows[i].mediumImage!),
                ),
                title: Text(state.shows[i].name!),
              ),
              itemCount: state.shows.length,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
