import 'package:hive/hive.dart';

import '../core.dart';

Future<void> openBoxes() async {
  await Hive.openBox(userPinBoxName);
  await Hive.openBox(signInWithFingerprintBoxName);
  await Hive.openBox(favoriteMoviesBoxName);
}