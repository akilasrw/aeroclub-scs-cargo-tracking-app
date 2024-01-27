import 'package:Cargo_Tracker/domain/data/airport.dart';
import 'package:Cargo_Tracker/domain/data/base_response.dart';
import 'package:Cargo_Tracker/domain/data/booking.dart';
import 'package:Cargo_Tracker/domain/data/cargo_agent.dart';
import 'package:Cargo_Tracker/domain/data/flight.dart';
import 'package:Cargo_Tracker/domain/data/load_uld_to_flight_request.dart';
import 'package:Cargo_Tracker/domain/repository/repository.dart';
import 'package:Cargo_Tracker/provider/base_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../domain/data/load_uld.dart';
import '../../domain/data/uld.dart';
import '../../domain/data/uld_flight_schedule.dart';
import '../../domain/shared/constants.dart';

class FlightLoadingProvider extends BaseProvider {
  late Repository repository;

  FlightLoadingProvider() {
    repository = repository = GetIt.I<Repository>();
  }

  List<Flight> flightList = List.empty();
  List<ULD> uldList = List.empty();
  var uldSerialNumberIdMap = {};

  initProvider() async {
    try {
      Future.delayed(const Duration(seconds: 2));
      var response = await repository!.getFlights();
      if (response != null) {
        flightList = response;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    notifyListeners();
  }

  getULDs(ULDFlightSchedule uldFlightSchedule) async {
    try {
      Future.delayed(const Duration(seconds: 2));
      var response = await repository!.getFlightsULDs(uldFlightSchedule);
      if (response != null) {

        uldList = response;
        for(ULD uld in uldList){
          uldSerialNumberIdMap[uld.serialNumber] = uld.id;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    notifyListeners();
  }

  Future<bool> loadUldToFlight(LoadULDtoFlightRequest loadULD) async {
    try{
      setLoading(true);
      var response = await repository.updatePackageAndBookingStatusFromULD(loadULD);
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
