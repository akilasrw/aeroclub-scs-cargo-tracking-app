

import 'package:Cargo_Tracker/domain/data/airport.dart';
import 'package:Cargo_Tracker/domain/data/base_response.dart';
import 'package:Cargo_Tracker/domain/data/booking.dart';
import 'package:Cargo_Tracker/domain/data/booking_status.dart';
import 'package:Cargo_Tracker/domain/data/cargo_agent.dart';
import 'package:Cargo_Tracker/domain/data/load_uld.dart';
import 'package:Cargo_Tracker/domain/data/load_uld_to_flight_request.dart';
import 'package:Cargo_Tracker/domain/data/login_request.dart';
import 'package:Cargo_Tracker/domain/data/login_response.dart';
import 'package:Cargo_Tracker/domain/data/uld.dart';

import '../../screen/load_to_uld/check_schedule_query.dart';
import '../../screen/pickup_cargo/check_awb_qrery.dart';
import '../../screen/update_packages/package.dart';
import '../../screen/update_packages/package_search.dart';
import '../data/flight.dart';
import '../data/package_awb.dart';
import '../data/package_filter/awb_filter.dart';
import '../data/package_filter/package_filter_req.dart';
import '../data/package_filter/package_filter_res.dart';
import '../data/package_filter/uld_filter.dart';
import '../data/sector.dart';
import '../data/uld_flight_schedule.dart';

abstract class RemoteHelper {

  Future<LoginResponse> loginUser(LoginRequest loginRequest);
  Future<List<Airport>?> getAirports();
  Future<List<CargoAgent>?> getCargoAgents();
  Future<BaseResponse> createTruckBookingAWBAndPackages(Booking bookingModel);
  Future<BaseResponse> updateStatusByPackage(BookingStatus bookingStatusModel);
  Future<List<Flight>?> getFlights();
  Future<BaseResponse> createFlightScheduleULDandUpdateStatus(LoadULD loadULD);
  Future<List<ULD>?> getFlightsULDs(ULDFlightSchedule uldFlightSchedule);
  Future<BaseResponse> updatePackageAndBookingStatusFromULD(LoadULDtoFlightRequest loadULDtoFlightRequest);
  Future<BaseResponse> completeUnpackULD(LoadULD loadULD);
  Future<List<PackageFilterRes>?> getPackageListByAWB(PackageFilterReq packageFilterReq);
  Future<List<String>?> getListByAwbAndStatus(PackageFilterReq packageFilterReq);
  Future<List<PackageAWB>?> getListByAwbAndUld(PackageFilterReq packageFilterReq);
  Future<Sector?> getAirportsByAWB(AWBFilter awbFilter);
  Future<List<ULD>?> getULDsBYStatus();
  Future<bool?> checkULDAvailability(ULDFilter awbFilter);
  Future<bool?> checkAWBAvailability(CheckAWBQuery awbFilter);
  Future<bool?> checkFlightScheduleAvailability(CheckScheduleQuery awbFilter);
  Future<BaseResponse> updatePackageItem(Package package);
  Future<Package?> getPackageFromAWBAndPackageRef(PackageSearch packageSearch);
}
