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
import '../../domain/data/package_filter/uld_filter.dart';
import '../../domain/data/sector.dart';
import '../../domain/data/uld.dart';
import '../../domain/data/uld_flight_schedule.dart';
import '../../domain/shared/constants.dart';
import '../unload_uld/uld_no_filter.dart';
import 'check_schedule_query.dart';

class ULDLoadProvider extends BaseProvider {
  late Repository repository;
  List<String> packagesByStatus = List.empty();
  List<String> uldSerialNumberList = [];
  var packageRefAwbNoMap = {};

  ULDLoadProvider() {
    repository = repository = GetIt.I<Repository>();
  }

  List<Flight> flightList = List.empty();

  initProvider(bool isLoading) async {
    if(isLoading){
      getGroundedULDs();
    }
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
          status.add(3);
          status.add(5);
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

  getULDs(ULDFlightSchedule uldFlightSchedule, bool isUnloadULD) async {
    try {
      setLoading(true);
      var response = await repository!.getFlightsULDs(uldFlightSchedule);
      if (response != null) {
        for (ULD uld in response) {
          if((!isUnloadULD && uld.status == 3) || (isUnloadULD && (uld.status == 2 || uld.status == 1))){
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

  getGroundedULDs() async {
    try {
      setLoading(true);
      var response = await repository!.getULDsBYStatus();
      if (response != null) {
        for (ULD uld in response) {
          uldSerialNumberList.add(uld.serialNumber);
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

  Future<bool?> checkULDAvailability(String flightNo, String flightDate, String uldNumber) async {
    try {
      setLoading(true);
      ULDFilter uldFilter = ULDFilter(uld: uldNumber, flightNum: flightNo, flightDate: flightDate);
      var response = await repository!.checkULDAvailability(uldFilter);
      if (response != null) {
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

  Future<bool?> checkFlightScheduleAvailability(String flightDate, String flightNo) async {
    try {
      setLoading(true);
      CheckScheduleQuery uldFilter = CheckScheduleQuery(flightNum: flightNo, date: flightDate);
      var response = await repository!.checkFlightScheduleAvailability(uldFilter);
      if (response != null) {
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

  Future<bool> unloadULD(String uldNum) async {
    try {
      setLoading(true);
      ULDNoFilter uldFilter = ULDNoFilter(uldNum: uldNum);
      var response = await repository.unloadULD(uldFilter);

        if (response != null && response) {
          setLoading(false);
          return Future.value(true);
        } else {
          setLoading(false);
          return Future.value(false);
        }

    } catch (e) {
      print(e);
      setLoading(false);
      return Future.value(false);
    }
    setLoading(false);
    return Future.value(false);
  }
}
