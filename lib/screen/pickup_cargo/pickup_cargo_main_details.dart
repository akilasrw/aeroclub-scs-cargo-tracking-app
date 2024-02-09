import 'dart:convert';

import 'package:Cargo_Tracker/domain/data/booking.dart';
import 'package:Cargo_Tracker/router/router.gr.dart';
import 'package:Cargo_Tracker/screen/pickup_cargo/provider.dart';
import 'package:Cargo_Tracker/screen/pickup_cargo/scan_cargo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:http/http.dart' as http;

import '../../domain/data/airport.dart';
import '../../domain/data/cargo_agent.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../common/main_button.dart';
import '../common/main_text_field.dart';
import '../common/navbar.dart';

@RoutePage()
class PickUpCargoMainDetailsPage extends StatefulWidget {
  const PickUpCargoMainDetailsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PickUpCargoMainDetailsState();
}

class _PickUpCargoMainDetailsState extends State<PickUpCargoMainDetailsPage> {
  String result = '';
  final TextEditingController awbController = TextEditingController();
  final TextEditingController truckController = TextEditingController();

  Airport? originAirport = null;
  Airport? desitnationAirport = null;
  CargoAgent? cargoAgent = null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
            backgroundColor: const Color(0xFF001C31),
            body: SafeArea(
                child: ChangeNotifierProvider(
                    create: (BuildContext context) =>
                        PickupProvider()..initProvider(),
                    builder: (context, child) {
                      return Consumer<PickupProvider>(
                          builder: (da, data, child) {
                        return Stack(
                          children: [
                            const Positioned(
                              top: 0,
                              right: 0,
                              left: 0,
                              child: Navbar(title: "Pick up Cargo"),
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: Center(
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: MainTextField(
                                                labelText: 'Track Number',
                                                onValueChanged: (bool value) {},
                                                controller: truckController,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        DropdownButtonFormField<CargoAgent>(
                                          isExpanded: true,
                                          icon: const Icon(Icons
                                              .arrow_drop_down_circle_rounded),
                                          elevation: 16,
                                          style: const TextStyle(
                                              color: Color(0xFF001C31)),
                                          decoration: dropdownDecoration
                                              .copyWith(hintText: "Agent"),
                                          onChanged: (CargoAgent? value) {
                                            // This is called when the user selects an item.
                                            setState(() {
                                              cargoAgent = value!;
                                            });
                                          },
                                          items: data.cargoAgents.map<
                                                  DropdownMenuItem<CargoAgent>>(
                                              (CargoAgent value) {
                                            return DropdownMenuItem<CargoAgent>(
                                              value: value,
                                              child: Text(value.agentName),
                                            );
                                          }).toList(),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        DropdownButtonFormField<Airport>(
                                          isExpanded: true,
                                          icon: const Icon(Icons
                                              .arrow_drop_down_circle_rounded),
                                          elevation: 16,
                                          style: const TextStyle(
                                              color: Color(0xFF001C31)),
                                          decoration: dropdownDecoration
                                              .copyWith(hintText: "Origin"),
                                          onChanged: (Airport? value) {
                                            // This is called when the user selects an item.
                                            setState(() {
                                              originAirport = value!;
                                            });
                                          },
                                          items: data.list
                                              .map<DropdownMenuItem<Airport>>(
                                                  (Airport value) {
                                            return DropdownMenuItem<Airport>(
                                              value: value,
                                              child: Text(value.value),
                                            );
                                          }).toList(),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        DropdownButtonFormField<Airport>(
                                          isExpanded: true,
                                          icon: const Icon(Icons
                                              .arrow_drop_down_circle_rounded),
                                          elevation: 16,
                                          style: const TextStyle(
                                              color: Color(0xFF001C31)),
                                          decoration:
                                              dropdownDecoration.copyWith(
                                                  hintText: "Destination"),
                                          onChanged: (Airport? value) {
                                            setState(() {
                                              desitnationAirport = value!;
                                            });
                                          },
                                          items: data.list
                                              .map<DropdownMenuItem<Airport>>(
                                                  (Airport value) {
                                            return DropdownMenuItem<Airport>(
                                              value: value,
                                              child: Text(value.value),
                                            );
                                          }).toList(),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: MainTextField(
                                                labelText: 'AWB No',
                                                onValueChanged: (bool value) {},
                                                controller: awbController,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                var res = await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const SimpleBarcodeScannerPage(),
                                                    ));
                                                setState(() {
                                                  if (res is String) {
                                                    result = res;
                                                    awbController.text = res;
                                                  }
                                                });
                                              },
                                              child: Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.blue,
                                                ),
                                                child: const Icon(
                                                  Icons.qr_code,
                                                  size: 25,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: MainButton(
                                      title: 'SUBMIT',
                                      onTapped: () {
                                        if (truckController.text.isEmpty) {
                                          showAlert("Please add truck number");
                                          return;
                                        }
                                        if (awbController.text.isEmpty) {
                                          showAlert("Please awb number");
                                          return;
                                        }
                                        if (originAirport == null) {
                                          showAlert("Please airport");
                                          return;
                                        }
                                        if (desitnationAirport == null) {
                                          showAlert("Please destination");
                                          return;
                                        }
                                        if (cargoAgent == null) {
                                          showAlert("Please cargo agent");
                                          return;
                                        }

                                        var booking = Booking(
                                            awbTrackingNumber:
                                                int.parse(awbController.text),
                                            origin: originAirport?.id,
                                            destination: desitnationAirport?.id,
                                            truckNo: truckController.text,
                                            cargoAgent: cargoAgent?.id,
                                            cargoAgentAppUserId:
                                                cargoAgent?.appUserId,
                                            packages: null);
                                        context.router.push(
                                            ScanCargoRoute(booking: booking));
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    color: const Color(0xFF223343),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xFF001C31),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              context.router.push(
                                                  HomeRoute());
                                            },
                                            child: Container(
                                              width: 40,
                                              height: 40,
                                              child: const Icon(
                                                Icons.home_outlined,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      });
                    }))));
  }

  void showAlert(String msg) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("ERROR!"),
            content: Text(msg),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        });
  }
}
