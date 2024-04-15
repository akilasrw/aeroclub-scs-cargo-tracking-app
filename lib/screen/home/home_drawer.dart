import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../data/local/local_storage.dart';
import '../../router/router.gr.dart';
import 'home_provider.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData _mediaQueryData = MediaQuery.of(context);
    final logoWidth = _mediaQueryData.size.width * 0.4;
    var _localStorage = LocalStorage();
    return Drawer(
      child : ChangeNotifierProvider(
        create: (BuildContext context) =>
    HomeProvider()..initProvider(),
    builder: (context, child) {
    return Consumer<HomeProvider>(
    builder: (da, data, child) {
      return ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                children: [
                  Center(
                    child: SvgPicture.asset(
                      'images/ikigai-cargo.svg',
                      colorBlendMode: BlendMode.srcIn,
                      width: logoWidth,
                    ),
                  )
                ],
              )

          ),
          (data.isAdminUser || data.isTruckDriver) ? ListTile(
            leading: const Icon(
              Icons.fire_truck_sharp,
            ),
            title: const Text('Pick up Cargo',
                style: TextStyle(fontSize: 18, color: Colors.black)),
            onTap: () {
              context.router.push(const PickUpCargoMainDetailsRoute());
            },
          ) : SizedBox(),
          (data.isAdminUser || data.isWarehouseUser) ? ListTile(
            leading: const Icon(
              Icons.warehouse,
            ),
            title: const Text('Handover to Warehouse',
                style: TextStyle(fontSize: 18, color: Colors.black)),
            onTap: () {
              context.router.push(const HandoverToWarehouseMainDetailsRoute());
            },
          ): SizedBox(),
          (data.isAdminUser || data.isWarehouseUser) ? ListTile(
            leading: const Icon(
              Icons.backpack,
            ),
            title: const Text('Pack to ULD',
                style: TextStyle(fontSize: 18, color: Colors.black)),
            onTap: () {
              context.router.push(ULDCargoLoadingRoute(isCargoLoading: true));
            },
          ): SizedBox(),
          (data.isAdminUser || data.isWarehouseUser) ? ListTile(
            leading: const Icon(
              Icons.remove_shopping_cart,
            ),
            title: const Text('Offload / Return Cargo',
                style: TextStyle(fontSize: 18, color: Colors.black)),
            onTap: () {
              context.router.push(OffloadCargoMainDetailsRoute());
            },
          ): SizedBox(),
          (data.isAdminUser || data.isWarehouseUser) ? ListTile(
            leading: const Icon(
              Icons.flight_takeoff,
            ),
            title: const Text('Flight Loading',
                style: TextStyle(fontSize: 18, color: Colors.black)),
            onTap: () {
              context.router.push(FlightLoadingRoute(isFlightLoading: true));
            },
          ): SizedBox(),
          (data.isAdminUser || data.isWarehouseUser) ? ListTile(
            leading: const Icon(
              Icons.flight_land,
            ),
            title: const Text('Flight Unloading',
                style: TextStyle(fontSize: 18, color: Colors.black)),
            onTap: () {
              context.router.push(FlightLoadingRoute(isFlightLoading: false));
            },
          ): SizedBox(),
          (data.isAdminUser || data.isWarehouseUser) ? ListTile(
            leading: const Icon(
              Icons.offline_pin_outlined,
            ),
            title: const Text('Unload ULD Cargo',
                style: TextStyle(fontSize: 18, color: Colors.black)),
            onTap: () {
              context.router.push(ULDCargoLoadingRoute(isCargoLoading: false));
            },
          ): SizedBox(),
          (data.isAdminUser || data.isWarehouseUser) ? ListTile(
            leading: const Icon(
              Icons.delivery_dining,
            ),
            title: const Text('Pack for Delivery',
                style: TextStyle(fontSize: 18, color: Colors.black)),
            onTap: () {
              context.router.push(PackForDeliveryRoute(isPackForDelivery: true));
            },
          ): SizedBox(),
          (data.isAdminUser || data.isTruckDriver) ? ListTile(
            leading: const Icon(
              Icons.handshake_outlined,
            ),
            title: const Text('Handover to Customer',
                style: TextStyle(fontSize: 18, color: Colors.black)),
            onTap: () {
              context.router.push(PackForDeliveryRoute(isPackForDelivery: false));
            },
          ) : SizedBox(),
          ListTile(
            leading: const Icon(
              Icons.logout,
            ),
            title: const Text('Logout',
                style: TextStyle(fontSize: 18, color: Colors.black)),
            onTap: () {
              _localStorage.logOutUser();
              context.router.push(const LoginRoute());
            },
          )
        ],
      );
    });})
      ,
    );
  }
}