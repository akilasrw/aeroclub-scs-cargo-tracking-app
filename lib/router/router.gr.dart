// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i18;
import 'package:Cargo_Tracker/domain/data/booking.dart' as _i22;
import 'package:Cargo_Tracker/domain/data/booking_status.dart' as _i21;
import 'package:Cargo_Tracker/domain/data/load_uld.dart' as _i23;
import 'package:Cargo_Tracker/domain/data/uld_flight_schedule.dart' as _i20;
import 'package:Cargo_Tracker/screen/common/scanner_view.dart' as _i6;
import 'package:Cargo_Tracker/screen/flight_loading/flight_loading_screen.dart'
    as _i1;
import 'package:Cargo_Tracker/screen/flight_loading/load_uld_to_flight.dart'
    as _i4;
import 'package:Cargo_Tracker/screen/flight_loading/uld_pack_list.dart' as _i16;
import 'package:Cargo_Tracker/screen/handover_to_warehouse/handover_to_warehouse_main_details.dart'
    as _i2;
import 'package:Cargo_Tracker/screen/handover_to_warehouse/scan_accept_cargo.dart'
    as _i10;
import 'package:Cargo_Tracker/screen/home/home.dart' as _i3;
import 'package:Cargo_Tracker/screen/load_to_uld/scan_uld_cargo.dart' as _i13;
import 'package:Cargo_Tracker/screen/load_to_uld/uld_cargo_loading_screen.dart'
    as _i15;
import 'package:Cargo_Tracker/screen/login/login_screen.dart' as _i5;
import 'package:Cargo_Tracker/screen/login/new_login_window.dart' as _i7;
import 'package:Cargo_Tracker/screen/pack_for_delivery/pack_for_delivery_screen.dart'
    as _i8;
import 'package:Cargo_Tracker/screen/pack_for_delivery/scan_pack_for_delivery.dart'
    as _i12;
import 'package:Cargo_Tracker/screen/pickup_cargo/pickup_cargo_main_details.dart'
    as _i9;
import 'package:Cargo_Tracker/screen/pickup_cargo/scan_cargo.dart' as _i11;
import 'package:Cargo_Tracker/screen/splash_page/view.dart' as _i14;
import 'package:Cargo_Tracker/screen/update_offloaded_cargo/update_offloaded_cargo_screen.dart'
    as _i17;
import 'package:flutter/cupertino.dart' as _i24;
import 'package:flutter/material.dart' as _i19;

abstract class $AppRouter extends _i18.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i18.PageFactory> pagesMap = {
    FlightLoadingRoute.name: (routeData) {
      final args = routeData.argsAs<FlightLoadingRouteArgs>();
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.FlightLoadingScreen(
          key: args.key,
          isFlightLoading: args.isFlightLoading,
        ),
      );
    },
    HandoverToWarehouseMainDetailsRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HandoverToWarehouseMainDetailsPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.HomePage(),
      );
    },
    LoadULDToFlightRoute.name: (routeData) {
      final args = routeData.argsAs<LoadULDToFlightRouteArgs>();
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.LoadULDToFlightPage(
          key: args.key,
          uldFlightSchedule: args.uldFlightSchedule,
          isFlightLoading: args.isFlightLoading,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.LoginScreen(),
      );
    },
    MyApp.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.MyApp(),
      );
    },
    NewCargoRoute.name: (routeData) {
      final args = routeData.argsAs<NewCargoRouteArgs>();
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.NewCargoScreen(
          key: args.key,
          isFlightLoading: args.isFlightLoading,
        ),
      );
    },
    PackForDeliveryRoute.name: (routeData) {
      final args = routeData.argsAs<PackForDeliveryRouteArgs>();
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.PackForDeliveryPage(
          key: args.key,
          isPackForDelivery: args.isPackForDelivery,
        ),
      );
    },
    PickUpCargoMainDetailsRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.PickUpCargoMainDetailsPage(),
      );
    },
    ScanAcceptCargoRoute.name: (routeData) {
      final args = routeData.argsAs<ScanAcceptCargoRouteArgs>();
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.ScanAcceptCargoPage(
          key: args.key,
          bookingStatus: args.bookingStatus,
        ),
      );
    },
    ScanCargoRoute.name: (routeData) {
      final args = routeData.argsAs<ScanCargoRouteArgs>();
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.ScanCargoPage(
          key: args.key,
          booking: args.booking,
        ),
      );
    },
    ScanPackForDeliveryRoute.name: (routeData) {
      final args = routeData.argsAs<ScanPackForDeliveryRouteArgs>();
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.ScanPackForDeliveryPage(
          key: args.key,
          bookingStatus: args.bookingStatus,
          isPackForDelivery: args.isPackForDelivery,
        ),
      );
    },
    ScanULDCargoRoute.name: (routeData) {
      final args = routeData.argsAs<ScanULDCargoRouteArgs>();
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.ScanULDCargoPage(
          key: args.key,
          loadULD: args.loadULD,
          isCargoLoading: args.isCargoLoading,
        ),
      );
    },
    SplashRouteRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.SplashPagePage(),
      );
    },
    ULDCargoLoadingRoute.name: (routeData) {
      final args = routeData.argsAs<ULDCargoLoadingRouteArgs>();
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.ULDCargoLoadingPage(
          key: args.key,
          isCargoLoading: args.isCargoLoading,
        ),
      );
    },
    ULDPackListRoute.name: (routeData) {
      final args = routeData.argsAs<ULDPackListRouteArgs>();
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i16.ULDPackListPage(
          key: args.key,
          uldFlightSchedule: args.uldFlightSchedule,
          isFlightLoading: args.isFlightLoading,
        ),
      );
    },
    UpdateOffloadedCargoRoute.name: (routeData) {
      final args = routeData.argsAs<UpdateOffloadedCargoRouteArgs>(
          orElse: () => const UpdateOffloadedCargoRouteArgs());
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.UpdateOffloadedCargoPage(key: args.key),
      );
    },
  };
}

/// generated route for
/// [_i1.FlightLoadingScreen]
class FlightLoadingRoute extends _i18.PageRouteInfo<FlightLoadingRouteArgs> {
  FlightLoadingRoute({
    _i19.Key? key,
    required bool isFlightLoading,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          FlightLoadingRoute.name,
          args: FlightLoadingRouteArgs(
            key: key,
            isFlightLoading: isFlightLoading,
          ),
          initialChildren: children,
        );

  static const String name = 'FlightLoadingRoute';

  static const _i18.PageInfo<FlightLoadingRouteArgs> page =
      _i18.PageInfo<FlightLoadingRouteArgs>(name);
}

class FlightLoadingRouteArgs {
  const FlightLoadingRouteArgs({
    this.key,
    required this.isFlightLoading,
  });

  final _i19.Key? key;

  final bool isFlightLoading;

  @override
  String toString() {
    return 'FlightLoadingRouteArgs{key: $key, isFlightLoading: $isFlightLoading}';
  }
}

/// generated route for
/// [_i2.HandoverToWarehouseMainDetailsPage]
class HandoverToWarehouseMainDetailsRoute extends _i18.PageRouteInfo<void> {
  const HandoverToWarehouseMainDetailsRoute(
      {List<_i18.PageRouteInfo>? children})
      : super(
          HandoverToWarehouseMainDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'HandoverToWarehouseMainDetailsRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i18.PageRouteInfo<void> {
  const HomeRoute({List<_i18.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i4.LoadULDToFlightPage]
class LoadULDToFlightRoute
    extends _i18.PageRouteInfo<LoadULDToFlightRouteArgs> {
  LoadULDToFlightRoute({
    _i19.Key? key,
    required _i20.ULDFlightSchedule uldFlightSchedule,
    required bool isFlightLoading,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          LoadULDToFlightRoute.name,
          args: LoadULDToFlightRouteArgs(
            key: key,
            uldFlightSchedule: uldFlightSchedule,
            isFlightLoading: isFlightLoading,
          ),
          initialChildren: children,
        );

  static const String name = 'LoadULDToFlightRoute';

  static const _i18.PageInfo<LoadULDToFlightRouteArgs> page =
      _i18.PageInfo<LoadULDToFlightRouteArgs>(name);
}

class LoadULDToFlightRouteArgs {
  const LoadULDToFlightRouteArgs({
    this.key,
    required this.uldFlightSchedule,
    required this.isFlightLoading,
  });

  final _i19.Key? key;

  final _i20.ULDFlightSchedule uldFlightSchedule;

  final bool isFlightLoading;

  @override
  String toString() {
    return 'LoadULDToFlightRouteArgs{key: $key, uldFlightSchedule: $uldFlightSchedule, isFlightLoading: $isFlightLoading}';
  }
}

/// generated route for
/// [_i5.LoginScreen]
class LoginRoute extends _i18.PageRouteInfo<void> {
  const LoginRoute({List<_i18.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i6.MyApp]
class MyApp extends _i18.PageRouteInfo<void> {
  const MyApp({List<_i18.PageRouteInfo>? children})
      : super(
          MyApp.name,
          initialChildren: children,
        );

  static const String name = 'MyApp';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i7.NewCargoScreen]
class NewCargoRoute extends _i18.PageRouteInfo<NewCargoRouteArgs> {
  NewCargoRoute({
    _i19.Key? key,
    required bool isFlightLoading,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          NewCargoRoute.name,
          args: NewCargoRouteArgs(
            key: key,
            isFlightLoading: isFlightLoading,
          ),
          initialChildren: children,
        );

  static const String name = 'NewCargoRoute';

  static const _i18.PageInfo<NewCargoRouteArgs> page =
      _i18.PageInfo<NewCargoRouteArgs>(name);
}

class NewCargoRouteArgs {
  const NewCargoRouteArgs({
    this.key,
    required this.isFlightLoading,
  });

  final _i19.Key? key;

  final bool isFlightLoading;

  @override
  String toString() {
    return 'NewCargoRouteArgs{key: $key, isFlightLoading: $isFlightLoading}';
  }
}

/// generated route for
/// [_i8.PackForDeliveryPage]
class PackForDeliveryRoute
    extends _i18.PageRouteInfo<PackForDeliveryRouteArgs> {
  PackForDeliveryRoute({
    _i19.Key? key,
    required bool isPackForDelivery,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          PackForDeliveryRoute.name,
          args: PackForDeliveryRouteArgs(
            key: key,
            isPackForDelivery: isPackForDelivery,
          ),
          initialChildren: children,
        );

  static const String name = 'PackForDeliveryRoute';

  static const _i18.PageInfo<PackForDeliveryRouteArgs> page =
      _i18.PageInfo<PackForDeliveryRouteArgs>(name);
}

class PackForDeliveryRouteArgs {
  const PackForDeliveryRouteArgs({
    this.key,
    required this.isPackForDelivery,
  });

  final _i19.Key? key;

  final bool isPackForDelivery;

  @override
  String toString() {
    return 'PackForDeliveryRouteArgs{key: $key, isPackForDelivery: $isPackForDelivery}';
  }
}

/// generated route for
/// [_i9.PickUpCargoMainDetailsPage]
class PickUpCargoMainDetailsRoute extends _i18.PageRouteInfo<void> {
  const PickUpCargoMainDetailsRoute({List<_i18.PageRouteInfo>? children})
      : super(
          PickUpCargoMainDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PickUpCargoMainDetailsRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i10.ScanAcceptCargoPage]
class ScanAcceptCargoRoute
    extends _i18.PageRouteInfo<ScanAcceptCargoRouteArgs> {
  ScanAcceptCargoRoute({
    _i19.Key? key,
    required _i21.BookingStatus bookingStatus,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          ScanAcceptCargoRoute.name,
          args: ScanAcceptCargoRouteArgs(
            key: key,
            bookingStatus: bookingStatus,
          ),
          initialChildren: children,
        );

  static const String name = 'ScanAcceptCargoRoute';

  static const _i18.PageInfo<ScanAcceptCargoRouteArgs> page =
      _i18.PageInfo<ScanAcceptCargoRouteArgs>(name);
}

class ScanAcceptCargoRouteArgs {
  const ScanAcceptCargoRouteArgs({
    this.key,
    required this.bookingStatus,
  });

  final _i19.Key? key;

  final _i21.BookingStatus bookingStatus;

  @override
  String toString() {
    return 'ScanAcceptCargoRouteArgs{key: $key, bookingStatus: $bookingStatus}';
  }
}

/// generated route for
/// [_i11.ScanCargoPage]
class ScanCargoRoute extends _i18.PageRouteInfo<ScanCargoRouteArgs> {
  ScanCargoRoute({
    _i19.Key? key,
    required _i22.Booking booking,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          ScanCargoRoute.name,
          args: ScanCargoRouteArgs(
            key: key,
            booking: booking,
          ),
          initialChildren: children,
        );

  static const String name = 'ScanCargoRoute';

  static const _i18.PageInfo<ScanCargoRouteArgs> page =
      _i18.PageInfo<ScanCargoRouteArgs>(name);
}

class ScanCargoRouteArgs {
  const ScanCargoRouteArgs({
    this.key,
    required this.booking,
  });

  final _i19.Key? key;

  final _i22.Booking booking;

  @override
  String toString() {
    return 'ScanCargoRouteArgs{key: $key, booking: $booking}';
  }
}

/// generated route for
/// [_i12.ScanPackForDeliveryPage]
class ScanPackForDeliveryRoute
    extends _i18.PageRouteInfo<ScanPackForDeliveryRouteArgs> {
  ScanPackForDeliveryRoute({
    _i19.Key? key,
    required _i21.BookingStatus bookingStatus,
    required bool isPackForDelivery,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          ScanPackForDeliveryRoute.name,
          args: ScanPackForDeliveryRouteArgs(
            key: key,
            bookingStatus: bookingStatus,
            isPackForDelivery: isPackForDelivery,
          ),
          initialChildren: children,
        );

  static const String name = 'ScanPackForDeliveryRoute';

  static const _i18.PageInfo<ScanPackForDeliveryRouteArgs> page =
      _i18.PageInfo<ScanPackForDeliveryRouteArgs>(name);
}

class ScanPackForDeliveryRouteArgs {
  const ScanPackForDeliveryRouteArgs({
    this.key,
    required this.bookingStatus,
    required this.isPackForDelivery,
  });

  final _i19.Key? key;

  final _i21.BookingStatus bookingStatus;

  final bool isPackForDelivery;

  @override
  String toString() {
    return 'ScanPackForDeliveryRouteArgs{key: $key, bookingStatus: $bookingStatus, isPackForDelivery: $isPackForDelivery}';
  }
}

/// generated route for
/// [_i13.ScanULDCargoPage]
class ScanULDCargoRoute extends _i18.PageRouteInfo<ScanULDCargoRouteArgs> {
  ScanULDCargoRoute({
    _i19.Key? key,
    required _i23.LoadULD loadULD,
    required bool isCargoLoading,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          ScanULDCargoRoute.name,
          args: ScanULDCargoRouteArgs(
            key: key,
            loadULD: loadULD,
            isCargoLoading: isCargoLoading,
          ),
          initialChildren: children,
        );

  static const String name = 'ScanULDCargoRoute';

  static const _i18.PageInfo<ScanULDCargoRouteArgs> page =
      _i18.PageInfo<ScanULDCargoRouteArgs>(name);
}

class ScanULDCargoRouteArgs {
  const ScanULDCargoRouteArgs({
    this.key,
    required this.loadULD,
    required this.isCargoLoading,
  });

  final _i19.Key? key;

  final _i23.LoadULD loadULD;

  final bool isCargoLoading;

  @override
  String toString() {
    return 'ScanULDCargoRouteArgs{key: $key, loadULD: $loadULD, isCargoLoading: $isCargoLoading}';
  }
}

/// generated route for
/// [_i14.SplashPagePage]
class SplashRouteRoute extends _i18.PageRouteInfo<void> {
  const SplashRouteRoute({List<_i18.PageRouteInfo>? children})
      : super(
          SplashRouteRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRouteRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i15.ULDCargoLoadingPage]
class ULDCargoLoadingRoute
    extends _i18.PageRouteInfo<ULDCargoLoadingRouteArgs> {
  ULDCargoLoadingRoute({
    _i19.Key? key,
    required bool isCargoLoading,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          ULDCargoLoadingRoute.name,
          args: ULDCargoLoadingRouteArgs(
            key: key,
            isCargoLoading: isCargoLoading,
          ),
          initialChildren: children,
        );

  static const String name = 'ULDCargoLoadingRoute';

  static const _i18.PageInfo<ULDCargoLoadingRouteArgs> page =
      _i18.PageInfo<ULDCargoLoadingRouteArgs>(name);
}

class ULDCargoLoadingRouteArgs {
  const ULDCargoLoadingRouteArgs({
    this.key,
    required this.isCargoLoading,
  });

  final _i19.Key? key;

  final bool isCargoLoading;

  @override
  String toString() {
    return 'ULDCargoLoadingRouteArgs{key: $key, isCargoLoading: $isCargoLoading}';
  }
}

/// generated route for
/// [_i16.ULDPackListPage]
class ULDPackListRoute extends _i18.PageRouteInfo<ULDPackListRouteArgs> {
  ULDPackListRoute({
    _i24.Key? key,
    required _i20.ULDFlightSchedule uldFlightSchedule,
    required bool isFlightLoading,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          ULDPackListRoute.name,
          args: ULDPackListRouteArgs(
            key: key,
            uldFlightSchedule: uldFlightSchedule,
            isFlightLoading: isFlightLoading,
          ),
          initialChildren: children,
        );

  static const String name = 'ULDPackListRoute';

  static const _i18.PageInfo<ULDPackListRouteArgs> page =
      _i18.PageInfo<ULDPackListRouteArgs>(name);
}

class ULDPackListRouteArgs {
  const ULDPackListRouteArgs({
    this.key,
    required this.uldFlightSchedule,
    required this.isFlightLoading,
  });

  final _i24.Key? key;

  final _i20.ULDFlightSchedule uldFlightSchedule;

  final bool isFlightLoading;

  @override
  String toString() {
    return 'ULDPackListRouteArgs{key: $key, uldFlightSchedule: $uldFlightSchedule, isFlightLoading: $isFlightLoading}';
  }
}

/// generated route for
/// [_i17.UpdateOffloadedCargoPage]
class UpdateOffloadedCargoRoute
    extends _i18.PageRouteInfo<UpdateOffloadedCargoRouteArgs> {
  UpdateOffloadedCargoRoute({
    _i19.Key? key,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          UpdateOffloadedCargoRoute.name,
          args: UpdateOffloadedCargoRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'UpdateOffloadedCargoRoute';

  static const _i18.PageInfo<UpdateOffloadedCargoRouteArgs> page =
      _i18.PageInfo<UpdateOffloadedCargoRouteArgs>(name);
}

class UpdateOffloadedCargoRouteArgs {
  const UpdateOffloadedCargoRouteArgs({this.key});

  final _i19.Key? key;

  @override
  String toString() {
    return 'UpdateOffloadedCargoRouteArgs{key: $key}';
  }
}
