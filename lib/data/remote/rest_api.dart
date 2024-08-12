import 'package:Cargo_Tracker/domain/data/airport.dart';
import 'package:Cargo_Tracker/domain/data/booking.dart';
import 'package:Cargo_Tracker/domain/data/booking_status.dart';
import 'package:Cargo_Tracker/domain/data/cargo_agent.dart';
import 'package:Cargo_Tracker/domain/data/flight.dart';
import 'package:Cargo_Tracker/domain/data/load_uld.dart';
import 'package:Cargo_Tracker/domain/data/load_uld_to_flight_request.dart';
import 'package:Cargo_Tracker/domain/data/login_request.dart';
import 'package:Cargo_Tracker/domain/data/login_response.dart';
import 'package:Cargo_Tracker/domain/data/uld.dart';
import 'package:auto_route/annotations.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

import '../../domain/data/base_response.dart';
import '../../domain/data/package_awb.dart';
import '../../domain/data/package_filter/awb_filter.dart';
import '../../domain/data/package_filter/package_filter_req.dart';
import '../../domain/data/package_filter/package_filter_res.dart';
import '../../domain/data/package_filter/uld_filter.dart';
import '../../domain/data/sector.dart';
import '../../domain/data/uld_flight_schedule.dart';

part 'rest_api.g.dart';

@RestApi(baseUrl: "")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("/api/v1/User/authenticate")
  Future<LoginResponse> loginUser(@Body() LoginRequest loginRequest);

  @POST("/api/v1/User/mobile/refresh-token")
  Future<LoginResponse> refreshToken(@Body() dynamic refreshToken);

  @GET("/api/v1/airport/getSelectList")
  Future<List<Airport>?> getAirports();

  @GET("/api/v1/CargoAgent/GetList")
  Future<List<CargoAgent>?> getCargoAgents();

  @POST("/api/v1/Package/CreateTruckBookingAWBAndPackages")
  Future<BaseResponse> createTruckBookingAWBAndPackages(@Body() Booking bookingModel);

  @PUT("/api/v1/Package/UpdateStatusByPackage")
  Future<BaseResponse> updateStatusByPackage(@Body() BookingStatus bookingStatus);

  @GET("/api/v1/Flight/getSelectListWithSectors")
  Future<List<Flight>?> getFlights();

  @POST("/api/v1/Package/CreateFlightScheduleULDandUpdateStatus")
  Future<BaseResponse> createFlightScheduleULDandUpdateStatus(@Body() LoadULD loadULD);

  @GET("/api/v1/ULD/ULDByFlightAndDate")
  Future<List<ULD>?> getFlightsULDs(@Body() ULDFlightSchedule uldFlightSchedule);

  @POST("/api/v1/Package/UpdatePackageAndBookingStatusFromULD")
  Future<BaseResponse> UpdatePackageAndBookingStatusFromULD(@Body() LoadULDtoFlightRequest loadULD);

  @POST("/api/v1/Package/UpdateULDAndPackageStatus")
  Future<BaseResponse> updateULDAndPackageStatus(@Body() LoadULD loadULD);

  @GET("/api/v1/Package/GetFilteredAllList")
  Future<List<PackageFilterRes>?> getPackageListByAWB(@Body() PackageFilterReq packageFilterReq);

  @GET("/api/v1/Package/GetListByAwbAndStatus")
  Future<List<String>?> getListByAwbAndStatus(@Body() PackageFilterReq packageFilterReq);

  @GET("/api/v1/Package/PackageByAwbAndUld")
  Future<List<PackageAWB>?> getListByAwbAndUld(@Body() PackageFilterReq packageFilterReq);

  @GET("/api/v1/CargoBooking/GetAirportsbyAWB")
  Future<Sector?> getAirportsByAWB(@Body() AWBFilter awbFilter);

  @GET("/api/v1/ULD/UldByStatus")
  Future<List<ULD>?> getULDsBYStatus();

  @POST("/api/v1/Package/CheckAvailability")
  Future<bool?> checkULDAvailability(@Body() ULDFilter awbFilter);
}
