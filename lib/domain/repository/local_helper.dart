

import 'package:Cargo_Tracker/domain/data/login_response.dart';

abstract class LocalHelper {
  Future<bool> logOutUser();
  Future<void> saveToken(LoginResponse tokenData);
  Future<String?> getAuthToken();
  Future<String?> getRefreshToken();
  Future<void> saveInSharedPreferences(String key, String value);
  Future<String?> getSharedPreferencesValue(String key);
// Future<String> getUserId();
  // UserData getUserDetailsModel();
}
