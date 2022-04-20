import 'package:hive/hive.dart';

import '../core.dart';

final userPinBox = Hive.box(userPinBoxName);
final signInWithFingerprintBox = Hive.box(signInWithFingerprintBoxName);
final favoriteMoviesBox = Hive.box(favoriteMoviesBoxName);