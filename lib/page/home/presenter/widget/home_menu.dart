import 'package:flutter/material.dart';

import 'package:expandable_fab_menu/expandable_fab_menu.dart';

import '../../../../core/core.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableFabMenu(
      onPress: () {},
      animatedIcon: AnimatedIcons.menu_home,
      animatedIconTheme: const IconThemeData(size: 22.0),
      child: const Icon(Icons.add),
      backgroundColor: Theme.of(context).colorScheme.primary,
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
          onTap: () => Navigator.of(context).pushNamed(favoritesShowsPage),
        ),
        ExpandableFabMenuItem(
          child: const Icon(Icons.visibility, color: Colors.white),
          title: 'People Search',
          titleColor: Colors.white,
          subtitle: 'Find people you want to know more about',
          subTitleColor: Colors.white,
          backgroundColor: Colors.green,
          onTap: () => Navigator.of(context).pushNamed(peopleSearchPage),
        ),
      ],
    );
  }
}
