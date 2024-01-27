import 'package:Cargo_Tracker/domain/data/airport.dart';
import 'package:Cargo_Tracker/domain/data/base_response.dart';
import 'package:Cargo_Tracker/domain/data/booking.dart';
import 'package:Cargo_Tracker/domain/data/booking_status.dart';
import 'package:Cargo_Tracker/domain/data/cargo_agent.dart';
import 'package:Cargo_Tracker/domain/repository/repository.dart';
import 'package:Cargo_Tracker/provider/base_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../domain/shared/constants.dart';

class HandoverWarehouseProvider extends BaseProvider {
  late Repository repository;

  HandoverWarehouseProvider() {
    repository = repository = GetIt.I<Repository>();
  }

  initProvider() async {
    notifyListeners();
  }

  Future<bool> handoverCargo(BookingStatus booking) async {
    try{
      setLoading(true);
      var response = await repository.updateStatusByPackage(booking);
      if(response.statusCode != null) {
        if (response.statusCode == ResultStatus.AllOK.value) {

        } else {

        }
        setLoading(false);
        return Future.value(true);
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
