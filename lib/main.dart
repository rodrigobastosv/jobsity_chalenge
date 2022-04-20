import 'package:flutter/material.dart';
import 'package:jobsity_chalenge/core/core.dart';
import 'package:jobsity_chalenge/repository_providers.dart';

import 'app.dart';

void main() {
  runApp(
    RepositoryProviders(
      client: getDefaultClient(),
      child: const App(),
    ),
  );
}
