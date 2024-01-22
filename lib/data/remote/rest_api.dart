import 'package:Cargo_Tracker/domain/data/airport.dart';
import 'package:Cargo_Tracker/domain/data/booking.dart';
import 'package:Cargo_Tracker/domain/data/cargo_agent.dart';
import 'package:Cargo_Tracker/domain/data/login_request.dart';
import 'package:Cargo_Tracker/domain/data/login_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_api.g.dart';

@RestApi(baseUrl: "")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("/api/v1/User/authenticate")
  Future<LoginResponse> loginUser(@Body() LoginRequest loginRequest);

  @POST("/api/v1/User/mobile/refresh-token")
  Future<LoginResponse> refreshToken(@Body() String refreshToken);

  @GET("/api/v1/airport/getSelectList")
  Future<List<Airport>?> getAirports();

  @GET("/api/v1/CargoAgent/GetList")
  Future<List<CargoAgent>?> getCargoAgents();

  @POST("/api/v1/Package/CreateTruckBookingAWBAndPackages")
  Future<bool> createTruckBookingAWBAndPackages(@Body() Booking bookingModel);


}
