import 'package:auto_route/auto_route.dart';
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
    AutoRoute(page: ScanAcceptCargoRoute.page),
    AutoRoute(page: ULDCargoLoadingRoute.page),
    AutoRoute(page: ScanULDCargoRoute.page),
    AutoRoute(page: FlightLoadingRoute.page),
    AutoRoute(page: LoadULDToFlightRoute.page),
    AutoRoute(page: PackForDeliveryRoute.page),
    AutoRoute(page: ScanPackForDeliveryRoute.page),
    AutoRoute(page: UpdateOffloadedCargoRoute.page),
    AutoRoute(page: ULDPackListRoute.page),
    AutoRoute(page: OffloadCargoMainDetailsRoute.page),
    AutoRoute(page: UnpackULDRoute.page),
    AutoRoute(page: ScanUnpackULDCargoRoute.page),
    AutoRoute(page: UpdatePackageRoute.page)
  ];
}