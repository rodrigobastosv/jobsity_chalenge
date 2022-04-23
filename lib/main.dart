import 'dart:io';

import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'app.dart';
import 'core/core.dart';
import 'core/storage/utils.dart';
import 'repository_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  await openBoxes();

  runApp(
    RepositoryProviders(
      client: getDefaultClient(),
      child: const App(),
    ),
  );
}
