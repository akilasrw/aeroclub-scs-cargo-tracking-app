// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i14;
import 'package:Cargo_Tracker/domain/data/booking.dart' as _i16;
import 'package:Cargo_Tracker/screen/flight_loading/flight_loading_screen.dart'
    as _i1;
import 'package:Cargo_Tracker/screen/flight_loading/load_uld_to_flight.dart'
    as _i4;
import 'package:Cargo_Tracker/screen/handover_to_warehouse/handover_to_warehouse_main_details.dart'
    as _i2;
import 'package:Cargo_Tracker/screen/handover_to_warehouse/scan_accept_cargo.dart'
    as _i8;
import 'package:Cargo_Tracker/screen/home/home.dart' as _i3;
import 'package:Cargo_Tracker/screen/load_to_uld/scan_uld_cargo.dart' as _i11;
import 'package:Cargo_Tracker/screen/load_to_uld/uld_cargo_loading_screen.dart'
    as _i12;
import 'package:Cargo_Tracker/screen/login/login_screen.dart' as _i5;
import 'package:Cargo_Tracker/screen/pack_for_delivery/pack_for_delivery_screen.dart'
    as _i6;
import 'package:Cargo_Tracker/screen/pack_for_delivery/scan_pack_for_delivery.dart'
    as _i10;
import 'package:Cargo_Tracker/screen/pickup_cargo/pickup_cargo_main_details.dart'
    as _i7;
import 'package:Cargo_Tracker/screen/pickup_cargo/scan_cargo.dart' as _i9;
import 'package:Cargo_Tracker/screen/update_offloaded_cargo/update_offloaded_cargo_screen.dart'
    as _i13;
import 'package:flutter/material.dart' as _i15;

abstract class $AppRouter extends _i14.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i14.PageFactory> pagesMap = {
    FlightLoadingRoute.name: (routeData) {
      final args = routeData.argsAs<FlightLoadingRouteArgs>();
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.FlightLoadingPage(
          key: args.key,
          isFlightLoading: args.isFlightLoading,
        ),
      );
    },
    HandoverToWarehouseMainDetailsRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HandoverToWarehouseMainDetailsPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.HomePage(),
      );
    },
    LoadULDToFlightRoute.name: (routeData) {
      final args = routeData.argsAs<LoadULDToFlightRouteArgs>(
          orElse: () => const LoadULDToFlightRouteArgs());
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.LoadULDToFlightPage(key: args.key),
      );
    },
    LoginRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.LoginScreen(),
      );
    },
    PackForDeliveryRoute.name: (routeData) {
      final args = routeData.argsAs<PackForDeliveryRouteArgs>();
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.PackForDeliveryPage(
          key: args.key,
          isPackForDelivery: args.isPackForDelivery,
        ),
      );
    },
    PickUpCargoMainDetailsRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.PickUpCargoMainDetailsPage(),
      );
    },
    ScanAcceptCargoRoute.name: (routeData) {
      final args = routeData.argsAs<ScanAcceptCargoRouteArgs>();
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.ScanAcceptCargoPage(
          key: args.key,
          booking: args.booking,
        ),
      );
    },
    ScanCargoRoute.name: (routeData) {
      final args = routeData.argsAs<ScanCargoRouteArgs>();
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.ScanCargoPage(
          key: args.key,
          booking: args.booking,
        ),
      );
    },
    ScanPackForDeliveryRoute.name: (routeData) {
      final args = routeData.argsAs<ScanPackForDeliveryRouteArgs>(
          orElse: () => const ScanPackForDeliveryRouteArgs());
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.ScanPackForDeliveryPage(key: args.key),
      );
    },
    ScanULDCargoRoute.name: (routeData) {
      final args = routeData.argsAs<ScanULDCargoRouteArgs>();
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.ScanULDCargoPage(
          key: args.key,
          booking: args.booking,
        ),
      );
    },
    ULDCargoLoadingRoute.name: (routeData) {
      final args = routeData.argsAs<ULDCargoLoadingRouteArgs>();
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.ULDCargoLoadingPage(
          key: args.key,
          isCargoLoading: args.isCargoLoading,
        ),
      );
    },
    UpdateOffloadedCargoRoute.name: (routeData) {
      final args = routeData.argsAs<UpdateOffloadedCargoRouteArgs>(
          orElse: () => const UpdateOffloadedCargoRouteArgs());
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.UpdateOffloadedCargoPage(key: args.key),
      );
    },
  };
}

/// generated route for
/// [_i1.FlightLoadingPage]
class FlightLoadingRoute extends _i14.PageRouteInfo<FlightLoadingRouteArgs> {
  FlightLoadingRoute({
    _i15.Key? key,
    required bool isFlightLoading,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          FlightLoadingRoute.name,
          args: FlightLoadingRouteArgs(
            key: key,
            isFlightLoading: isFlightLoading,
          ),
          initialChildren: children,
        );

  static const String name = 'FlightLoadingRoute';

  static const _i14.PageInfo<FlightLoadingRouteArgs> page =
      _i14.PageInfo<FlightLoadingRouteArgs>(name);
}

class FlightLoadingRouteArgs {
  const FlightLoadingRouteArgs({
    this.key,
    required this.isFlightLoading,
  });

  final _i15.Key? key;

  final bool isFlightLoading;

  @override
  String toString() {
    return 'FlightLoadingRouteArgs{key: $key, isFlightLoading: $isFlightLoading}';
  }
}

/// generated route for
/// [_i2.HandoverToWarehouseMainDetailsPage]
class HandoverToWarehouseMainDetailsRoute extends _i14.PageRouteInfo<void> {
  const HandoverToWarehouseMainDetailsRoute(
      {List<_i14.PageRouteInfo>? children})
      : super(
          HandoverToWarehouseMainDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'HandoverToWarehouseMainDetailsRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i14.PageRouteInfo<void> {
  const HomeRoute({List<_i14.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i4.LoadULDToFlightPage]
class LoadULDToFlightRoute
    extends _i14.PageRouteInfo<LoadULDToFlightRouteArgs> {
  LoadULDToFlightRoute({
    _i15.Key? key,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          LoadULDToFlightRoute.name,
          args: LoadULDToFlightRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'LoadULDToFlightRoute';

  static const _i14.PageInfo<LoadULDToFlightRouteArgs> page =
      _i14.PageInfo<LoadULDToFlightRouteArgs>(name);
}

class LoadULDToFlightRouteArgs {
  const LoadULDToFlightRouteArgs({this.key});

  final _i15.Key? key;

  @override
  String toString() {
    return 'LoadULDToFlightRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i5.LoginScreen]
class LoginRoute extends _i14.PageRouteInfo<void> {
  const LoginRoute({List<_i14.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i6.PackForDeliveryPage]
class PackForDeliveryRoute
    extends _i14.PageRouteInfo<PackForDeliveryRouteArgs> {
  PackForDeliveryRoute({
    _i15.Key? key,
    required bool isPackForDelivery,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          PackForDeliveryRoute.name,
          args: PackForDeliveryRouteArgs(
            key: key,
            isPackForDelivery: isPackForDelivery,
          ),
          initialChildren: children,
        );

  static const String name = 'PackForDeliveryRoute';

  static const _i14.PageInfo<PackForDeliveryRouteArgs> page =
      _i14.PageInfo<PackForDeliveryRouteArgs>(name);
}

class PackForDeliveryRouteArgs {
  const PackForDeliveryRouteArgs({
    this.key,
    required this.isPackForDelivery,
  });

  final _i15.Key? key;

  final bool isPackForDelivery;

  @override
  String toString() {
    return 'PackForDeliveryRouteArgs{key: $key, isPackForDelivery: $isPackForDelivery}';
  }
}

/// generated route for
/// [_i7.PickUpCargoMainDetailsPage]
class PickUpCargoMainDetailsRoute extends _i14.PageRouteInfo<void> {
  const PickUpCargoMainDetailsRoute({List<_i14.PageRouteInfo>? children})
      : super(
          PickUpCargoMainDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PickUpCargoMainDetailsRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i8.ScanAcceptCargoPage]
class ScanAcceptCargoRoute
    extends _i14.PageRouteInfo<ScanAcceptCargoRouteArgs> {
  ScanAcceptCargoRoute({
    _i15.Key? key,
    required _i16.Booking booking,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          ScanAcceptCargoRoute.name,
          args: ScanAcceptCargoRouteArgs(
            key: key,
            booking: booking,
          ),
          initialChildren: children,
        );

  static const String name = 'ScanAcceptCargoRoute';

  static const _i14.PageInfo<ScanAcceptCargoRouteArgs> page =
      _i14.PageInfo<ScanAcceptCargoRouteArgs>(name);
}

class ScanAcceptCargoRouteArgs {
  const ScanAcceptCargoRouteArgs({
    this.key,
    required this.booking,
  });

  final _i15.Key? key;

  final _i16.Booking booking;

  @override
  String toString() {
    return 'ScanAcceptCargoRouteArgs{key: $key, booking: $booking}';
  }
}

/// generated route for
/// [_i9.ScanCargoPage]
class ScanCargoRoute extends _i14.PageRouteInfo<ScanCargoRouteArgs> {
  ScanCargoRoute({
    _i15.Key? key,
    required _i16.Booking booking,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          ScanCargoRoute.name,
          args: ScanCargoRouteArgs(
            key: key,
            booking: booking,
          ),
          initialChildren: children,
        );

  static const String name = 'ScanCargoRoute';

  static const _i14.PageInfo<ScanCargoRouteArgs> page =
      _i14.PageInfo<ScanCargoRouteArgs>(name);
}

class ScanCargoRouteArgs {
  const ScanCargoRouteArgs({
    this.key,
    required this.booking,
  });

  final _i15.Key? key;

  final _i16.Booking booking;

  @override
  String toString() {
    return 'ScanCargoRouteArgs{key: $key, booking: $booking}';
  }
}

/// generated route for
/// [_i10.ScanPackForDeliveryPage]
class ScanPackForDeliveryRoute
    extends _i14.PageRouteInfo<ScanPackForDeliveryRouteArgs> {
  ScanPackForDeliveryRoute({
    _i15.Key? key,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          ScanPackForDeliveryRoute.name,
          args: ScanPackForDeliveryRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'ScanPackForDeliveryRoute';

  static const _i14.PageInfo<ScanPackForDeliveryRouteArgs> page =
      _i14.PageInfo<ScanPackForDeliveryRouteArgs>(name);
}

class ScanPackForDeliveryRouteArgs {
  const ScanPackForDeliveryRouteArgs({this.key});

  final _i15.Key? key;

  @override
  String toString() {
    return 'ScanPackForDeliveryRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i11.ScanULDCargoPage]
class ScanULDCargoRoute extends _i14.PageRouteInfo<ScanULDCargoRouteArgs> {
  ScanULDCargoRoute({
    _i15.Key? key,
    required _i16.Booking booking,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          ScanULDCargoRoute.name,
          args: ScanULDCargoRouteArgs(
            key: key,
            booking: booking,
          ),
          initialChildren: children,
        );

  static const String name = 'ScanULDCargoRoute';

  static const _i14.PageInfo<ScanULDCargoRouteArgs> page =
      _i14.PageInfo<ScanULDCargoRouteArgs>(name);
}

class ScanULDCargoRouteArgs {
  const ScanULDCargoRouteArgs({
    this.key,
    required this.booking,
  });

  final _i15.Key? key;

  final _i16.Booking booking;

  @override
  String toString() {
    return 'ScanULDCargoRouteArgs{key: $key, booking: $booking}';
  }
}

/// generated route for
/// [_i12.ULDCargoLoadingPage]
class ULDCargoLoadingRoute
    extends _i14.PageRouteInfo<ULDCargoLoadingRouteArgs> {
  ULDCargoLoadingRoute({
    _i15.Key? key,
    required bool isCargoLoading,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          ULDCargoLoadingRoute.name,
          args: ULDCargoLoadingRouteArgs(
            key: key,
            isCargoLoading: isCargoLoading,
          ),
          initialChildren: children,
        );

  static const String name = 'ULDCargoLoadingRoute';

  static const _i14.PageInfo<ULDCargoLoadingRouteArgs> page =
      _i14.PageInfo<ULDCargoLoadingRouteArgs>(name);
}

class ULDCargoLoadingRouteArgs {
  const ULDCargoLoadingRouteArgs({
    this.key,
    required this.isCargoLoading,
  });

  final _i15.Key? key;

  final bool isCargoLoading;

  @override
  String toString() {
    return 'ULDCargoLoadingRouteArgs{key: $key, isCargoLoading: $isCargoLoading}';
  }
}

/// generated route for
/// [_i13.UpdateOffloadedCargoPage]
class UpdateOffloadedCargoRoute
    extends _i14.PageRouteInfo<UpdateOffloadedCargoRouteArgs> {
  UpdateOffloadedCargoRoute({
    _i15.Key? key,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          UpdateOffloadedCargoRoute.name,
          args: UpdateOffloadedCargoRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'UpdateOffloadedCargoRoute';

  static const _i14.PageInfo<UpdateOffloadedCargoRouteArgs> page =
      _i14.PageInfo<UpdateOffloadedCargoRouteArgs>(name);
}

class UpdateOffloadedCargoRouteArgs {
  const UpdateOffloadedCargoRouteArgs({this.key});

  final _i15.Key? key;

  @override
  String toString() {
    return 'UpdateOffloadedCargoRouteArgs{key: $key}';
  }
}
