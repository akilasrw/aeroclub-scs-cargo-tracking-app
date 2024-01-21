

import 'package:Cargo_Tracker/domain/data/airport.dart';
import 'package:Cargo_Tracker/domain/data/cargo_agent.dart';
import 'package:Cargo_Tracker/domain/data/login_request.dart';
import 'package:Cargo_Tracker/domain/data/login_response.dart';

abstract class RemoteHelper {

  Future<LoginResponse> loginUser(LoginRequest loginRequest);
  Future<List<Airport>?> getAirports();
  Future<List<CargoAgent>?> getCargoAgents();

}
