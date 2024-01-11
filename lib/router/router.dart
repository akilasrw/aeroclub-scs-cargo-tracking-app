import 'package:Cargo_Tracker/screen/home/home.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import 'package:simple_barcode_scanner/constant.dart';

import 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page,initial: true),
    AutoRoute(page: PickUpCargoMainDetailsRoute.page),
    AutoRoute(page: ScanCargoRoute.page),
  ];
}