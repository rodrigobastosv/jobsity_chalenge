import 'package:hive/hive.dart';

import '../data.dart';

class HiveSignInRepository implements SignInRepository {
  HiveSignInRepository(this._box);

  final Box _box;

  @override
  Future<bool> signInUser(String pin) async {
    final usersPins = _box.get('USERS_PIN_POOL') as List?;
    
    if (usersPins?.contains(pin) ?? false) {
      _box.put('USER_PIN', pin);
    }
 
    return usersPins?.contains(pin) ?? false;
  }

}