import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:jobsity_chalenge/core/core.dart';
import '../../data.dart';

void main() {
  test(
    'app router ...',
    () {
      final signIn = AppRouter.generateRoutes(
        const RouteSettings(
          name: signInPage,
        ),
      );
      expect(signIn.settings.name, signInPage);

      final signUp = AppRouter.generateRoutes(
        const RouteSettings(
          name: signUpPage,
        ),
      );
      expect(signUp.settings.name, signUpPage);

      final home = AppRouter.generateRoutes(
        const RouteSettings(
          name: homePage,
        ),
      );
      expect(home.settings.name, homePage);

      final showDetails = AppRouter.generateRoutes(
        const RouteSettings(
          name: showDetailsPage,
        ),
      );
      expect(showDetails.settings.name, showDetailsPage);

      final peopleSearch = AppRouter.generateRoutes(
        const RouteSettings(
          name: peopleSearchPage,
          arguments: episodeFake,
        ),
      );
      expect(peopleSearch.settings.name, peopleSearchPage);

      final personDetails = AppRouter.generateRoutes(
        const RouteSettings(
          name: personDetailsPage,
        ),
      );
      expect(personDetails.settings.name, personDetailsPage);
    },
  );
}
