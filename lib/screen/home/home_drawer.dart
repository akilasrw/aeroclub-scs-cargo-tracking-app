import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../router/router.gr.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData _mediaQueryData = MediaQuery.of(context);
    final logoWidth = _mediaQueryData.size.width * 0.4;
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
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
          ListTile(
            leading: const Icon(
              Icons.fire_truck_sharp,
            ),
            title: const Text('Pick up Cargo',
                style: TextStyle(fontSize: 18, color: Colors.black)),
            onTap: () {
              context.router.push(const PickUpCargoMainDetailsRoute());
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.warehouse,
            ),
            title: const Text('Handover to Warehouse',
                style: TextStyle(fontSize: 18, color: Colors.black)),
            onTap: () {
              context.router.push(const HandoverToWarehouseMainDetailsRoute());
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.backpack,
            ),
            title: const Text('Pack to ULD',
                style: TextStyle(fontSize: 18, color: Colors.black)),
            onTap: () {
              context.router.push(ULDCargoLoadingRoute(isCargoLoading: true));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.remove_shopping_cart,
            ),
            title: const Text('Offload / Return Cargo',
                style: TextStyle(fontSize: 18, color: Colors.black)),
            onTap: () {
              context.router.push(UpdateOffloadedCargoRoute());
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.flight_takeoff,
            ),
            title: const Text('Flight Loading',
                style: TextStyle(fontSize: 18, color: Colors.black)),
            onTap: () {
              context.router.push(FlightLoadingRoute(isFlightLoading: true));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.flight_land,
            ),
            title: const Text('Flight Unloading',
                style: TextStyle(fontSize: 18, color: Colors.black)),
            onTap: () {
              context.router.push(FlightLoadingRoute(isFlightLoading: false));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.offline_pin_outlined,
            ),
            title: const Text('Unload ULD Cargo',
                style: TextStyle(fontSize: 18, color: Colors.black)),
            onTap: () {
              context.router.push(ULDCargoLoadingRoute(isCargoLoading: false));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.delivery_dining,
            ),
            title: const Text('Pack for Delivery',
                style: TextStyle(fontSize: 18, color: Colors.black)),
            onTap: () {
              context.router.push(PackForDeliveryRoute(isPackForDelivery: true));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.handshake_outlined,
            ),
            title: const Text('Handover to Customer',
                style: TextStyle(fontSize: 18, color: Colors.black)),
            onTap: () {
              context.router.push(PackForDeliveryRoute(isPackForDelivery: false));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
            ),
            title: const Text('Logout',
                style: TextStyle(fontSize: 18, color: Colors.black)),
            onTap: () {

            },
          )
        ],
      ),
    );
  }
}