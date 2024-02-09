import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../router/router.gr.dart';

class HomeGrid extends StatelessWidget {
  final bool isAdminUser;
  final bool isWarehouseUser;
  final bool isTruckDriver;
  const HomeGrid({super.key, required this.isAdminUser ,
    required this.isWarehouseUser , required this.isTruckDriver});



  @override
  Widget build(BuildContext context) {
    List menuList = [
      _MenuItem(Icons.fire_truck_sharp, 'Pick up Cargo', true , PickUpCargoMainDetailsRoute()),
      _MenuItem(Icons.warehouse, 'WH Receiving' , false , HandoverToWarehouseMainDetailsRoute()),
      _MenuItem(Icons.backpack, 'Pack ULD', false , ULDCargoLoadingRoute(isCargoLoading: true)),
      _MenuItem(Icons.remove_shopping_cart, 'Standby / Return' , false , UpdateOffloadedCargoRoute()),
      _MenuItem(Icons.flight_takeoff, 'Flight Loading',false , FlightLoadingRoute(isFlightLoading: true)),
      _MenuItem(Icons.flight_land, 'Flight Unloading',false , FlightLoadingRoute(isFlightLoading: false)),
      _MenuItem(Icons.offline_pin_outlined, 'Unload ULD',false, ULDCargoLoadingRoute(isCargoLoading: false)),
      _MenuItem(Icons.delivery_dining, 'Customer Delivery',false,PackForDeliveryRoute(isPackForDelivery: true)),
      _MenuItem(Icons.handshake_outlined, 'Agent Pickup',true ,PackForDeliveryRoute(isPackForDelivery: false)),
    ];

    menuList.removeWhere((menu) => ((isTruckDriver && !menu.isTruckDriverMenu) ||
        (isWarehouseUser && menu.isTruckDriverMenu)));
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 1.2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemBuilder: (context, position) {
            return  Padding(
                padding: const EdgeInsets.all(5.0),
                child: InkWell(
                    onTap: () {
                      context.router.push(menuList[position].route);
                    },
                    child: Center(
                      child: Column(
                        children: [
                          Center(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0)),
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Icon(
                                  menuList[position].icon,
                                  size: 40,
                                  color: Colors.lightBlueAccent,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                menuList[position].title,
                                textAlign: TextAlign.center,
                                style: TextStyle(),
                              ),
                            ),
                          )
                        ],
                      ),
                    )));
          },
          itemCount: menuList.length,
        )
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final bool isTruckDriverMenu;
  final PageRouteInfo route;

  _MenuItem(this.icon, this.title , this.isTruckDriverMenu , this.route);
}