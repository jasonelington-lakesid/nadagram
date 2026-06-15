import '../models/user.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class UserRepository {
  Box<User> get _box => Hive.box<User>('User');

  Future<void> addNewFavorite(User user) async {
    await _box.add(user);
  }

  List<User> getAll() {
    return _box.values.toList();
  }
}