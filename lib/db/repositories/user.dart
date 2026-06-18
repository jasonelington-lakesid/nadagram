import '../models/user.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class UserRepository {
  Box<User> get box => Hive.box<User>('User');

  Future<void> addNewFavorite(int contentIndex) async {
    User user = box.get('currentUser') ??
      User(favorited: {}, isDarkMode: false);
    user.favorited.add(contentIndex);
    await box.put('currentUser', user);
  }

  Future<void> removeFavorite(int contentIndex) async {
    User user = box.get('currentUser') ??
      User(favorited: {}, isDarkMode: false);

    user.favorited.remove(contentIndex);
    await box.put('currentUser', user);
  }

  Set<int> getAllFavorites() {
    return box.get('currentUser')?.favorited ?? {};
  }

  Future<void> setDarkMode(bool darkModeStatus) async {
    User user = box.get('currentUser') ??
      User(favorited: {}, isDarkMode: false);
    
    user.isDarkMode = darkModeStatus;
    await box.put('currentUser', user);
  }

  bool getDarkMode()  {
    return box.get('currentUser')?.isDarkMode ?? false;
  }
}