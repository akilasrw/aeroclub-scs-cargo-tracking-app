// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:Cargo_Tracker/domain/data/booking.dart' as _i9;
import 'package:Cargo_Tracker/screen/handover_to_warehouse/handover_to_warehouse_main_details.dart'
    as _i1;
import 'package:Cargo_Tracker/screen/handover_to_warehouse/scan_accept_cargo.dart'
    as _i5;
import 'package:Cargo_Tracker/screen/home/home.dart' as _i2;
import 'package:Cargo_Tracker/screen/login/login_screen.dart' as _i3;
import 'package:Cargo_Tracker/screen/pickup_cargo/pickup_cargo_main_details.dart'
    as _i4;
import 'package:Cargo_Tracker/screen/pickup_cargo/scan_cargo.dart' as _i6;
import 'package:flutter/material.dart' as _i8;

abstract class $AppRouter extends _i7.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    HandoverToWarehouseMainDetailsRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.HandoverToWarehouseMainDetailsPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomePage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.LoginScreen(),
      );
    },
    PickUpCargoMainDetailsRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.PickUpCargoMainDetailsPage(),
      );
    },
    ScanAcceptCargoRoute.name: (routeData) {
      final args = routeData.argsAs<ScanAcceptCargoRouteArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.ScanAcceptCargoPage(
          key: args.key,
          booking: args.booking,
        ),
      );
    },
    ScanCargoRoute.name: (routeData) {
      final args = routeData.argsAs<ScanCargoRouteArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.ScanCargoPage(
          key: args.key,
          booking: args.booking,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.HandoverToWarehouseMainDetailsPage]
class HandoverToWarehouseMainDetailsRoute extends _i7.PageRouteInfo<void> {
  const HandoverToWarehouseMainDetailsRoute({List<_i7.PageRouteInfo>? children})
      : super(
          HandoverToWarehouseMainDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'HandoverToWarehouseMainDetailsRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute({List<_i7.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i3.LoginScreen]
class LoginRoute extends _i7.PageRouteInfo<void> {
  const LoginRoute({List<_i7.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i4.PickUpCargoMainDetailsPage]
class PickUpCargoMainDetailsRoute extends _i7.PageRouteInfo<void> {
  const PickUpCargoMainDetailsRoute({List<_i7.PageRouteInfo>? children})
      : super(
          PickUpCargoMainDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PickUpCargoMainDetailsRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i5.ScanAcceptCargoPage]
class ScanAcceptCargoRoute extends _i7.PageRouteInfo<ScanAcceptCargoRouteArgs> {
  ScanAcceptCargoRoute({
    _i8.Key? key,
    required _i9.Booking booking,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          ScanAcceptCargoRoute.name,
          args: ScanAcceptCargoRouteArgs(
            key: key,
            booking: booking,
          ),
          initialChildren: children,
        );

  static const String name = 'ScanAcceptCargoRoute';

  static const _i7.PageInfo<ScanAcceptCargoRouteArgs> page =
      _i7.PageInfo<ScanAcceptCargoRouteArgs>(name);
}

class ScanAcceptCargoRouteArgs {
  const ScanAcceptCargoRouteArgs({
    this.key,
    required this.booking,
  });

  final _i8.Key? key;

  final _i9.Booking booking;

  @override
  String toString() {
    return 'ScanAcceptCargoRouteArgs{key: $key, booking: $booking}';
  }
}

/// generated route for
/// [_i6.ScanCargoPage]
class ScanCargoRoute extends _i7.PageRouteInfo<ScanCargoRouteArgs> {
  ScanCargoRoute({
    _i8.Key? key,
    required _i9.Booking booking,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          ScanCargoRoute.name,
          args: ScanCargoRouteArgs(
            key: key,
            booking: booking,
          ),
          initialChildren: children,
        );

  static const String name = 'ScanCargoRoute';

  static const _i7.PageInfo<ScanCargoRouteArgs> page =
      _i7.PageInfo<ScanCargoRouteArgs>(name);
}

class ScanCargoRouteArgs {
  const ScanCargoRouteArgs({
    this.key,
    required this.booking,
  });

  final _i8.Key? key;

  final _i9.Booking booking;

  @override
  String toString() {
    return 'ScanCargoRouteArgs{key: $key, booking: $booking}';
  }
}
