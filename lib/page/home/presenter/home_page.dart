import 'package:expandable_fab_menu/expandable_fab_menu.dart';
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
          floatingActionButton: ExpandableFabMenu(
            onPress: () {},
            animatedIcon: AnimatedIcons.menu_home,
            animatedIconTheme: const IconThemeData(size: 22.0),
            child: const Icon(Icons.add),
            backgroundColor: Theme.of(context).colorScheme.primary,
            onOpen: () => debugPrint('OPENING DIAL'),
            onClose: () => debugPrint('DIAL CLOSED'),
            overlayColor: Colors.black,
            overlayOpacity: 0.7,
            children: [
              ExpandableFabMenuItem(
                child: const Icon(Icons.favorite, color: Colors.white),
                title: 'Favorite Shows',
                titleColor: Colors.white,
                subtitle: 'Manage your favorite shows',
                subTitleColor: Colors.white,
                backgroundColor: Colors.amber,
                onTap: () => debugPrint('FIRST CHILD'),
              ),
              ExpandableFabMenuItem(
                child: const Icon(Icons.visibility, color: Colors.white),
                title: 'People Search',
                titleColor: Colors.white,
                subtitle: 'Find people you want to know more about',
                subTitleColor: Colors.white,
                backgroundColor: Colors.green,
                onTap: () => debugPrint('SECOND CHILD'),
              ),
              ExpandableFabMenuItem(
                child: const Icon(Icons.settings, color: Colors.white),
                title: 'Settings',
                titleColor: Colors.white,
                subtitle: 'Adjust the settings of the app',
                subTitleColor: Colors.white,
                backgroundColor: Colors.blue,
                onTap: () => debugPrint('THIRD CHILD'),
              ),
            ],
          ),
        );
      },
    );
  }
}
