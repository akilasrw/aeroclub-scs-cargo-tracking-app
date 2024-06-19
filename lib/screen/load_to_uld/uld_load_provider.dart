import 'package:Cargo_Tracker/domain/data/flight.dart';
import 'package:Cargo_Tracker/domain/data/package_filter/awb_filter.dart';
import 'package:Cargo_Tracker/domain/repository/repository.dart';
import 'package:Cargo_Tracker/provider/base_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../../domain/data/load_uld.dart';
import '../../domain/data/package_awb.dart';
import '../../domain/data/package_filter/package_filter_req.dart';
import '../../domain/data/package_filter/package_filter_res.dart';
import '../../domain/data/sector.dart';
import '../../domain/data/uld.dart';
import '../../domain/data/uld_flight_schedule.dart';
import '../../domain/shared/constants.dart';

class ULDLoadProvider extends BaseProvider {
  late Repository repository;
  List<String> packagesByStatus = List.empty();
  List<String> uldSerialNumberList = [];
  var packageRefAwbNoMap = {};

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
    try {
      setLoading(true);
      var response =
          await repository.createFlightScheduleULDandUpdateStatus(loadULD);
      if (response.status != null) {
        if (response.status == ResultStatus.AllOK.value) {
          setLoading(false);
          return Future.value(true);
        } else {
          setLoading(false);
          return Future.value(false);
        }
      }
    } catch (e) {
      print(e);
      setLoading(false);
      return Future.value(false);
    }

    setLoading(false);
    return Future.value(false);
  }

  Future<bool> unpackToULD(LoadULD loadULD) async {
    try {
      setLoading(true);
      var response = await repository.completeUnpackULD(loadULD);
      if (response.status != null) {
        if (response.status == ResultStatus.AllOK.value) {
        } else {}
        setLoading(false);
        return Future.value(true);
      }
    } catch (e) {
      print(e);
      setLoading(false);
      return Future.value(false);
    }

    setLoading(false);
    return Future.value(false);
  }

  loadPackagesByStatus(
      String awbNumber, bool isCargoLoading, String uldNo) async {
    try {
      //Future.delayed(const Duration(seconds: 2));
      if (isCargoLoading) {
        List<int> status = [];
          status.add(2);
          status.add(4);
        var response = await repository!.getListByAwbAndStatus(PackageFilterReq(
            awbNumber: int.parse(awbNumber), packageItemStatuses: status));
        if (response != null) {
          packagesByStatus = response;
        }
      } else {
        var response = await repository!.getListByAwbAndUld(PackageFilterReq(uld: uldNo));
        if (response != null) {
          for(PackageAWB packageAWB in response){
            packageRefAwbNoMap[packageAWB.packageRef] = packageAWB.awbNum;
          }

        }
      }
    } catch (e) {
      setLoading(false);
      if (kDebugMode) {
        print(e);
      }
    }
    notifyListeners();
  }

  getULDs(ULDFlightSchedule uldFlightSchedule) async {
    try {
      setLoading(true);
      var response = await repository!.getFlightsULDs(uldFlightSchedule);
      if (response != null) {
        for (ULD uld in response) {
          if(uld.status == 3){
            uldSerialNumberList.add(uld.serialNumber);
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
        setLoading(false);
      }
    }
    setLoading(false);
    notifyListeners();
  }

  Future<Sector?> getAirportsByAWB(int awbNo) async {
    try {
      setLoading(true);
      AWBFilter awbFilter = AWBFilter(awbTrackingNum: awbNo);
      var response = await repository!.getAirportsByAWB(awbFilter);
      if (response != null) {
        setLoading(false);
        return response;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
        setLoading(false);
      }
    }
    setLoading(false);
    notifyListeners();
  }
}
