import 'package:Cargo_Tracker/domain/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SplashPageProvider extends ChangeNotifier {
  late Repository repository;

  SplashPageProvider() {
    repository = repository = GetIt.I<Repository>();
  }

  Future<bool> isUserAuthenticate() async {
    var auth = await repository!.getAuthToken();
    if (auth != null) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }
}
