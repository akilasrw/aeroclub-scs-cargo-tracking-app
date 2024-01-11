// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:Cargo_Tracker/domain/data/booking.dart' as _i6;
import 'package:Cargo_Tracker/screen/home/home.dart' as _i1;
import 'package:Cargo_Tracker/screen/pickup_cargo/pickup_cargo_main_details.dart'
    as _i2;
import 'package:Cargo_Tracker/screen/pickup_cargo/scan_cargo.dart' as _i3;
import 'package:flutter/material.dart' as _i5;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.HomePage(),
      );
    },
    PickUpCargoMainDetailsRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.PickUpCargoMainDetailsPage(),
      );
    },
    ScanCargoRoute.name: (routeData) {
      final args = routeData.argsAs<ScanCargoRouteArgs>();
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.ScanCargoPage(
          key: args.key,
          booking: args.booking,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute({List<_i4.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i2.PickUpCargoMainDetailsPage]
class PickUpCargoMainDetailsRoute extends _i4.PageRouteInfo<void> {
  const PickUpCargoMainDetailsRoute({List<_i4.PageRouteInfo>? children})
      : super(
          PickUpCargoMainDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PickUpCargoMainDetailsRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i3.ScanCargoPage]
class ScanCargoRoute extends _i4.PageRouteInfo<ScanCargoRouteArgs> {
  ScanCargoRoute({
    _i5.Key? key,
    required _i6.Booking booking,
    List<_i4.PageRouteInfo>? children,
  }) : super(
          ScanCargoRoute.name,
          args: ScanCargoRouteArgs(
            key: key,
            booking: booking,
          ),
          initialChildren: children,
        );

  static const String name = 'ScanCargoRoute';

  static const _i4.PageInfo<ScanCargoRouteArgs> page =
      _i4.PageInfo<ScanCargoRouteArgs>(name);
}

class ScanCargoRouteArgs {
  const ScanCargoRouteArgs({
    this.key,
    required this.booking,
  });

  final _i5.Key? key;

  final _i6.Booking booking;

  @override
  String toString() {
    return 'ScanCargoRouteArgs{key: $key, booking: $booking}';
  }
}
