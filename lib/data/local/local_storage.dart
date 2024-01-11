import 'package:Cargo_Tracker/domain/repository/local_helper.dart';
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


}
