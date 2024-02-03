import 'package:Cargo_Tracker/domain/data/airport.dart';
import 'package:Cargo_Tracker/domain/data/base_response.dart';
import 'package:Cargo_Tracker/domain/data/booking.dart';
import 'package:Cargo_Tracker/domain/data/booking_status.dart';
import 'package:Cargo_Tracker/domain/data/cargo_agent.dart';
import 'package:Cargo_Tracker/domain/data/package_filter/package_filter_req.dart';
import 'package:Cargo_Tracker/domain/repository/repository.dart';
import 'package:Cargo_Tracker/provider/base_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../domain/data/package_filter/package_filter_res.dart';
import '../../domain/shared/constants.dart';

class HandoverWarehouseProvider extends BaseProvider {
  late Repository repository;
  List<PackageFilterRes> bookedPackageItems = List.empty();

  HandoverWarehouseProvider() {
    repository = repository = GetIt.I<Repository>();
  }

  initProvider() async {
    notifyListeners();
  }

  loadScannedPackages(int awbNumber) async {
    setLoading(true);
    try {
      //Future.delayed(const Duration(seconds: 2));
      var response = await repository!.getPackageListByAWB(PackageFilterReq
        (awbNumber: awbNumber, includeCargoBooking: false));
      if (response != null) {
        bookedPackageItems = response;
      }
    } catch (e) {
      setLoading(false);
      if (kDebugMode) {
        print(e);
      }
    }
    setLoading(false);
    notifyListeners();
  }

  Future<bool> handoverCargo(BookingStatus booking) async {
    try{
      setLoading(true);
      var response = await repository.updateStatusByPackage(booking);
      if(response.status != null) {
        if (response.status == ResultStatus.AllOK.value) {
          setLoading(false);
          return Future.value(true);
        } else {
          setLoading(false);
          return Future.value(false);
        }
      }
    }catch(e){
      print(e);
      setLoading(false);
      return Future.value(false);
    }

    setLoading(false);
    return Future.value(false);
  }
}
