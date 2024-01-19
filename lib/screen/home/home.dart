import 'package:Cargo_Tracker/router/router.gr.dart';
import 'package:Cargo_Tracker/screen/pickup_cargo/pickup_cargo_main_details.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Home"),
        ),
        body: Center(
          child : SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size.fromHeight(50), // NEW
                        ),
                        onPressed: () {
                          context.router.push(const PickUpCargoMainDetailsRoute());
                        },
                        child: const Text(
                          'Pick up Cargo',
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size.fromHeight(50), // NEW
                        ),
                        onPressed: () {
                          context.router.push(const HandoverToWarehouseMainDetailsRoute());
                        },
                        child: const Text(
                          'Handover to Warehouse',
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        )),const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size.fromHeight(50), // NEW
                        ),
                        onPressed: () {
                          context.router.push(ULDCargoLoadingRoute(isCargoLoading: true));
                        },
                        child: const Text(
                          'Pack to ULD',
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        )),const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size.fromHeight(50), // NEW
                        ),
                        onPressed: () {
                          context.router.push(UpdateOffloadedCargoRoute());
                        },
                        child: const Text(
                          'Update Offload Cargo',
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        )),const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size.fromHeight(50), // NEW
                        ),
                        onPressed: () {
                          context.router.push(FlightLoadingRoute(isFlightLoading: true));
                        },
                        child: const Text(
                          'Flight Loading',
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        )),const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size.fromHeight(50), // NEW
                        ),
                        onPressed: () {
                          context.router.push(FlightLoadingRoute(isFlightLoading: false));
                        },
                        child: const Text(
                          'Flight Unloading',
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        )),const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size.fromHeight(50), // NEW
                        ),
                        onPressed: () {
                          context.router.push(ULDCargoLoadingRoute(isCargoLoading: false));
                        },
                        child: const Text(
                          'Unload ULD Cargo',
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        )),const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size.fromHeight(50), // NEW
                        ),
                        onPressed: () {
                          context.router.push(PackForDeliveryRoute(isPackForDelivery: true));
                        },
                        child: const Text(
                          'Pack for Delivery',
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        )),const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size.fromHeight(50), // NEW
                        ),
                        onPressed: () {
                          context.router.push(PackForDeliveryRoute(isPackForDelivery: false));
                        },
                        child: const Text(
                          'Handover to Customer',
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ))
                  ],
                ),
              )
          )
          ,
        ));
  }
}
