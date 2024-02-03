import 'package:Cargo_Tracker/domain/data/airport.dart';
import 'package:Cargo_Tracker/domain/data/base_response.dart';
import 'package:Cargo_Tracker/domain/data/booking.dart';
import 'package:Cargo_Tracker/domain/data/cargo_agent.dart';
import 'package:Cargo_Tracker/domain/repository/repository.dart';
import 'package:Cargo_Tracker/provider/base_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../domain/shared/constants.dart';

class PickupProvider extends BaseProvider {
  late Repository repository;

  PickupProvider() {
    repository = repository = GetIt.I<Repository>();
  }

  List<Airport> list = List.empty();
  List<CargoAgent> cargoAgents = List.empty();

  initProvider() async {
    setLoading(true);
    try {
      //Future.delayed(const Duration(seconds: 2));
      var response = await repository!.getAirports();
      if (response != null) {
        list = response;
      }
      var cargoAgentsResponse = await repository!.getCargoAgents();
      if (cargoAgentsResponse != null) {
        cargoAgents = cargoAgentsResponse;
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

  Future<bool> pickupCargo(BuildContext context,Booking booking) async {
    try{
      setLoading(true);
      var response = await repository.createTruckBookingAWBAndPackages(booking);
      setLoading(false);
      if(response.status == ResultStatus.AllOK.value){
        return Future.value(true);
      }
      return Future.value(false);

    }catch(e){
      print(e);
      setLoading(false);
      return Future.value(false);
    }
  }
}
