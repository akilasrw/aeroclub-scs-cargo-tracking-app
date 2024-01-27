import 'package:Cargo_Tracker/domain/data/flight.dart';
import 'package:Cargo_Tracker/domain/repository/repository.dart';
import 'package:Cargo_Tracker/provider/base_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../../domain/data/load_uld.dart';
import '../../domain/shared/constants.dart';

class ULDLoadProvider extends BaseProvider {
  late Repository repository;

  ULDLoadProvider() {
    repository = repository = GetIt.I<Repository>();
  }

  List<Flight> flightList = List.empty();

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

  Future<bool> packToULD(LoadULD loadULD) async {
    try{
      setLoading(true);
      var response = await repository.createFlightScheduleULDandUpdateStatus(loadULD);
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

  Future<bool> unpackToULD(LoadULD loadULD) async {
    try{
      setLoading(true);
      var response = await repository.completeUnpackULD(loadULD);
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
