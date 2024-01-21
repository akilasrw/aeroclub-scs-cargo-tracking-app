import 'package:Cargo_Tracker/screen/home/home.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import 'package:simple_barcode_scanner/constant.dart';

import '../screen/handover_to_warehouse/handover_to_warehouse_main_details.dart';
import 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRouteRoute.page,initial: true),
    AutoRoute(page: LoginRoute.page,),
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: PickUpCargoMainDetailsRoute.page),
    AutoRoute(page: ScanCargoRoute.page),
    AutoRoute(page: HandoverToWarehouseMainDetailsRoute.page),
    AutoRoute(page: ScanAcceptCargoRoute.page)
  ];
}