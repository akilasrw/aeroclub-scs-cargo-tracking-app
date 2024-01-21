// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:Cargo_Tracker/domain/data/booking.dart' as _i10;
import 'package:Cargo_Tracker/screen/handover_to_warehouse/handover_to_warehouse_main_details.dart'
    as _i1;
import 'package:Cargo_Tracker/screen/handover_to_warehouse/scan_accept_cargo.dart'
    as _i5;
import 'package:Cargo_Tracker/screen/home/home.dart' as _i2;
import 'package:Cargo_Tracker/screen/login/login_screen.dart' as _i3;
import 'package:Cargo_Tracker/screen/pickup_cargo/pickup_cargo_main_details.dart'
    as _i4;
import 'package:Cargo_Tracker/screen/pickup_cargo/scan_cargo.dart' as _i6;
import 'package:Cargo_Tracker/screen/splash_page/view.dart' as _i7;
import 'package:flutter/material.dart' as _i9;

abstract class $AppRouter extends _i8.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    HandoverToWarehouseMainDetailsRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.HandoverToWarehouseMainDetailsPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomePage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.LoginScreen(),
      );
    },
    PickUpCargoMainDetailsRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.PickUpCargoMainDetailsPage(),
      );
    },
    ScanAcceptCargoRoute.name: (routeData) {
      final args = routeData.argsAs<ScanAcceptCargoRouteArgs>();
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.ScanAcceptCargoPage(
          key: args.key,
          booking: args.booking,
        ),
      );
    },
    ScanCargoRoute.name: (routeData) {
      final args = routeData.argsAs<ScanCargoRouteArgs>();
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.ScanCargoPage(
          key: args.key,
          booking: args.booking,
        ),
      );
    },
    SplashRouteRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.SplashPagePage(),
      );
    },
  };
}

/// generated route for
/// [_i1.HandoverToWarehouseMainDetailsPage]
class HandoverToWarehouseMainDetailsRoute extends _i8.PageRouteInfo<void> {
  const HandoverToWarehouseMainDetailsRoute({List<_i8.PageRouteInfo>? children})
      : super(
          HandoverToWarehouseMainDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'HandoverToWarehouseMainDetailsRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute({List<_i8.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i3.LoginScreen]
class LoginRoute extends _i8.PageRouteInfo<void> {
  const LoginRoute({List<_i8.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i4.PickUpCargoMainDetailsPage]
class PickUpCargoMainDetailsRoute extends _i8.PageRouteInfo<void> {
  const PickUpCargoMainDetailsRoute({List<_i8.PageRouteInfo>? children})
      : super(
          PickUpCargoMainDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PickUpCargoMainDetailsRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i5.ScanAcceptCargoPage]
class ScanAcceptCargoRoute extends _i8.PageRouteInfo<ScanAcceptCargoRouteArgs> {
  ScanAcceptCargoRoute({
    _i9.Key? key,
    required _i10.Booking booking,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          ScanAcceptCargoRoute.name,
          args: ScanAcceptCargoRouteArgs(
            key: key,
            booking: booking,
          ),
          initialChildren: children,
        );

  static const String name = 'ScanAcceptCargoRoute';

  static const _i8.PageInfo<ScanAcceptCargoRouteArgs> page =
      _i8.PageInfo<ScanAcceptCargoRouteArgs>(name);
}

class ScanAcceptCargoRouteArgs {
  const ScanAcceptCargoRouteArgs({
    this.key,
    required this.booking,
  });

  final _i9.Key? key;

  final _i10.Booking booking;

  @override
  String toString() {
    return 'ScanAcceptCargoRouteArgs{key: $key, booking: $booking}';
  }
}

/// generated route for
/// [_i6.ScanCargoPage]
class ScanCargoRoute extends _i8.PageRouteInfo<ScanCargoRouteArgs> {
  ScanCargoRoute({
    _i9.Key? key,
    required _i10.Booking booking,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          ScanCargoRoute.name,
          args: ScanCargoRouteArgs(
            key: key,
            booking: booking,
          ),
          initialChildren: children,
        );

  static const String name = 'ScanCargoRoute';

  static const _i8.PageInfo<ScanCargoRouteArgs> page =
      _i8.PageInfo<ScanCargoRouteArgs>(name);
}

class ScanCargoRouteArgs {
  const ScanCargoRouteArgs({
    this.key,
    required this.booking,
  });

  final _i9.Key? key;

  final _i10.Booking booking;

  @override
  String toString() {
    return 'ScanCargoRouteArgs{key: $key, booking: $booking}';
  }
}

/// generated route for
/// [_i7.SplashPagePage]
class SplashRouteRoute extends _i8.PageRouteInfo<void> {
  const SplashRouteRoute({List<_i8.PageRouteInfo>? children})
      : super(
          SplashRouteRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRouteRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}
