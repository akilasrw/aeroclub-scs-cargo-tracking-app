import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
      _MenuItem('images/1.svg', 'Pick up Cargo' , const Color(0xFF072B3D), true , PickUpCargoMainDetailsRoute()),
      _MenuItem('images/2.svg', 'WH Receiving', const Color(0xFF102730), false , HandoverToWarehouseMainDetailsRoute()),
      _MenuItem('images/3.svg', 'Pack ULD', const Color(0xFF032B33),false , ULDCargoLoadingRoute(isCargoLoading: true)),
      _MenuItem('images/4.svg', 'Standby / Return' , const Color(0xFF171E35),false , UpdateOffloadedCargoRoute()),
      _MenuItem('images/5.svg', 'Flight Loading',const Color(0xFF14242D),false , FlightLoadingRoute(isFlightLoading: true)),
      _MenuItem('images/6.svg', 'Flight Unloading',const Color(0xFF032335),false , FlightLoadingRoute(isFlightLoading: false)),
      _MenuItem('images/7.svg', 'Unpack ULD',const Color(0xFF0B1D3D),false, ULDCargoLoadingRoute(isCargoLoading: false)),
      _MenuItem('images/8.svg', 'Customer Delivery',const Color(0xFF041B45),false,PackForDeliveryRoute(isPackForDelivery: true)),
      _MenuItem('images/9.svg', 'Agent Pickup',const Color(0xFF082337),true ,PackForDeliveryRoute(isPackForDelivery: false)),
    ];

    menuList.removeWhere((menu) => ((isTruckDriver && !menu.isTruckDriverMenu) ||
        (isWarehouseUser && menu.isTruckDriverMenu)));
    final MediaQueryData _mediaQueryData = MediaQuery.of(context);
    final iconWidth = _mediaQueryData.size.width * 0.13;
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 270,
              childAspectRatio: 1.4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8
          ),
          itemBuilder: (context, position) {
            return  Padding(
                padding: const EdgeInsets.all(1.0),
                child: InkWell(
                    onTap: () {
                      context.router.push(menuList[position].route);
                    },
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: menuList[position].color,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1), // Set shadow color
                                spreadRadius: 1, // Set spread radius
                                blurRadius: 2, // Set blur radius
                                offset: Offset(0, 1), // Offset of the shadow
                              ),
                            ]
                        ),
                        child: Column(
                          children: [
                            Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: MediaQuery.of(context).size.height * 0.1,
                                child: Card(
                                  color: Colors.transparent,
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        menuList[position].icon,
                                        colorBlendMode: BlendMode.srcIn,
                                        width: iconWidth,
                                      ),
                                    ),
                                    // child: Icon(
                                    //   menuList[position].icon,
                                    //   size: 40,
                                    //   color: Colors.lightBlueAccent,
                                    // ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  menuList[position].title,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )));
          },
          itemCount: menuList.length,
        )
    );
  }
}

class _MenuItem {
  final String icon;
  final String title;
  final Color color;
  final bool isTruckDriverMenu;
  final PageRouteInfo route;

  _MenuItem(this.icon,  this.title , this.color, this.isTruckDriverMenu , this.route);
}