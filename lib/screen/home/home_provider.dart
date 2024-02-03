import 'dart:convert';

import 'package:Cargo_Tracker/domain/repository/repository.dart';
import 'package:Cargo_Tracker/provider/base_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

class HomeProvider extends BaseProvider {
  late Repository repository;
  List<String> allowedUserRoles = ["Warehouse User","Super Admin","Warehouse Admin"];
  bool isAdminUser = false;
  bool isWarehouseUser = false;
  bool isTruckDriver = false;
  HomeProvider() {
    repository = repository = GetIt.I<Repository>();
  }

  initProvider() async {
    try {
     // String val = getUserRole() as String;
      var val = await repository.getSharedPreferencesValue("userRole");

      isAdminUser = "Super Admin" == val;
      isWarehouseUser = "Warehouse User" == val || "Warehouse Admin" == val;
      isTruckDriver = "Truck Driver" == val;

    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    notifyListeners();
  }
}
