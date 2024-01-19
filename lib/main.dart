import 'dart:async';

import 'package:Cargo_Tracker/app.dart';
import 'package:Cargo_Tracker/data/repository_iml.dart';
import 'package:Cargo_Tracker/domain/repository/repository.dart';
import 'package:Cargo_Tracker/router/router.dart';
import 'package:Cargo_Tracker/screen/app/messege_service.dart';
import 'package:Cargo_Tracker/screen/home/home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() async {
  await runZonedGuarded(
        () async {
      WidgetsFlutterBinding.ensureInitialized();
      GetIt.I.registerSingleton<MessageService>(MessageService());
      GetIt.I.registerSingleton<AppRouter>(AppRouter());
      GetIt.I.registerSingleton<Repository>(RepositoryImpl(
        // baseURL: 'https://aeroclub-skytechcargo-app-dev-002.azurewebsites.net/',
        baseURL: 'https://localhost:7130',
      ));
      runApp(const App());
    },
        (dynamic error, dynamic stackTrace) {
      if (kDebugMode) {
        print(error);
      }
    },
  );
}
