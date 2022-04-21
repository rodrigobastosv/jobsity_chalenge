import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:jobsity_chalenge/core/core.dart';
import 'package:jobsity_chalenge/core/storage/utils.dart';
import 'package:jobsity_chalenge/repository_providers.dart';
import 'package:path_provider/path_provider.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  await openBoxes();

  // TODO: remove mock pin later
  await userPinBox.put('USER_PIN', 1);

  runApp(
    RepositoryProviders(
      client: getDefaultClient(),
      child: const App(),
    ),
  );
}
