import 'package:Cargo_Tracker/domain/data/airport.dart';
import 'package:Cargo_Tracker/domain/data/cargo_agent.dart';
import 'package:Cargo_Tracker/domain/repository/repository.dart';
import 'package:Cargo_Tracker/provider/base_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

class PickupProvider extends BaseProvider {
  late Repository repository;

  PickupProvider() {
    repository = repository = GetIt.I<Repository>();
  }

  List<Airport> list = List.empty();
  List<CargoAgent> cargoAgents = List.empty();

  initProvider() async {
    try {
      Future.delayed(const Duration(seconds: 2));
      var response = await repository!.getAirports();
      if (response != null) {
        list = response;
      }
      var cargoAgentsResponse = await repository!.getCargoAgents();
      if (cargoAgentsResponse != null) {
        cargoAgents = cargoAgentsResponse;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    notifyListeners();
  }
}
