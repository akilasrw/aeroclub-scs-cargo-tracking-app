import 'package:Cargo_Tracker/domain/data/login_response.dart';
import 'package:Cargo_Tracker/domain/repository/local_helper.dart';
import 'package:Cargo_Tracker/utils/constants.dart';
import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage extends LocalHelper {
  SharedPreferences? _sharedPreferences;

  LocalStorage() {
    initLocalStorage();
  }

  void initLocalStorage() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Future<bool> logOutUser() {
    return _sharedPreferences!.clear();
  }

  @override
  Future<String?> getAuthToken() async {
    var tokenDataString =
    _sharedPreferences?.getString(SHARED_PREFERENCES_AUTH_TOKEN);
    return tokenDataString;
  }

  @override
  Future<String?> getRefreshToken() async {
    var tokenDataString =
    _sharedPreferences?.getString(SHARED_PREFERENCES_REFRESH_TOKEN);
    return tokenDataString;
  }

  @override
  Future<void> saveToken(LoginResponse tokenResponse) async {
    if (tokenResponse != null && tokenResponse.jwtToken != null && tokenResponse.refreshToken!= null) {
      await _sharedPreferences?.setString(
    SHARED_PREFERENCES_AUTH_TOKEN, tokenResponse.jwtToken!);
    await _sharedPreferences?.setString(
    SHARED_PREFERENCES_REFRESH_TOKEN, tokenResponse.refreshToken!);
    }
    return Future.value(true);
  }

}
