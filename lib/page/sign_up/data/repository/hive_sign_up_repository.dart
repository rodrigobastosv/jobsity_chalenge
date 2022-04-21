import 'package:hive/hive.dart';

import '../data.dart';

class HiveSignUpRepository implements SignUpRepository {
  HiveSignUpRepository(this._box);

  final Box _box;

  @override
  Future<void> signUpUser(String pin) async {
    final usersPins = _box.get('USERS_PIN_POOL');

    await _box.put(
      'USERS_PIN_POOL',
      [
        if (usersPins != null) ...usersPins,
        pin,
      ],
    );
  }
}
