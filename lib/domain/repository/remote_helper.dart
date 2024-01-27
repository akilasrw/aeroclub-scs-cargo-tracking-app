

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

import '../data/flight.dart';
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
}
