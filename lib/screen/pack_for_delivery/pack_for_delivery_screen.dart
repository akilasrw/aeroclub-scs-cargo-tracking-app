import 'dart:convert';

import 'package:Cargo_Tracker/router/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../domain/data/airport.dart';
import '../../domain/data/booking_status.dart';
import '../../domain/data/cargo_agent.dart';
import '../pickup_cargo/provider.dart';

@RoutePage()
class PackForDeliveryPage extends StatefulWidget {
  final bool isPackForDelivery;

  const PackForDeliveryPage({Key? key, required this.isPackForDelivery})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PickUpCargoMainDetailsState();
}

class _PickUpCargoMainDetailsState extends State<PackForDeliveryPage> {
  final TextEditingController truckController = TextEditingController();
  final TextEditingController awbController = TextEditingController();
  CargoAgent? cargoAgent = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
          title: Text(widget.isPackForDelivery
              ? "Pack for Delivery"
              : "Handover to Customer"),
        ),
        body: Center(
            child: SingleChildScrollView(
                child: Container(
                    margin: const EdgeInsets.all(30.0),
                    child: ChangeNotifierProvider(
                        create: (BuildContext context) =>
                        PickupProvider()
                          ..initProvider(),
                        builder: (context, child) {
                          return Consumer<PickupProvider>(
                              builder: (da, data, child) {
                                return Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.teal)),
                                          labelText: 'Truck Number',
                                        ),
                                        controller: truckController,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      DropdownButtonFormField<CargoAgent>(
                                        isExpanded: true,
                                        icon: const Icon(
                                            Icons
                                                .arrow_drop_down_circle_rounded),
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.deepPurple),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.teal)),
                                          labelText: 'Agent',
                                        ),
                                        onChanged: (CargoAgent? value) {
                                          // This is called when the user selects an item.
                                          setState(() {
                                            cargoAgent = value!;
                                          });
                                        },
                                        items: data.cargoAgents
                                            .map<DropdownMenuItem<CargoAgent>>(
                                                (CargoAgent value) {
                                              return DropdownMenuItem<
                                                  CargoAgent>(
                                                value: value,
                                                child: Text(value.agentName),
                                              );
                                            }).toList(),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Expanded(
                                                flex: 8,
                                                child: TextField(
                                                    controller: awbController,
                                                    style: TextStyle(
                                                        color: Colors.black45),
                                                    decoration: const InputDecoration(
                                                      border: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .teal)),
                                                      labelText: 'AWB No',
                                                    ))),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Material(
                                                type: MaterialType.transparency,
                                                child: Ink(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .indigoAccent,
                                                        width: 3.0),
                                                    color: Colors.indigo[900],
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: InkWell(
                                                    //This keeps the splash effect within the circle
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        1000.0),
                                                    //Something large to ensure a circle
                                                    onTap: () async {
                                                      var res = await Navigator
                                                          .push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                            const SimpleBarcodeScannerPage(),
                                                          ));
                                                      setState(() {
                                                        if (res is String) {
                                                          awbController.text =
                                                              res;
                                                        }
                                                      });
                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsets.all(
                                                          15.0),
                                                      child: Icon(
                                                        Icons
                                                            .document_scanner_outlined,
                                                        size: 25.0,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                            minimumSize: const Size.fromHeight(
                                                50), // NEW
                                          ),
                                          onPressed: () {
                                            if (truckController.text.isEmpty) {
                                              showAlert(
                                                  "Please add truck number");
                                              return;
                                            }
                                            if (awbController.text.isEmpty) {
                                              showAlert(
                                                  "Please add awb number");
                                              return;
                                            }
                                            var bookingStatus = BookingStatus(
                                                awbNumber:
                                                int.parse(awbController.text),
                                                truckNo: truckController.text,
                                                status: widget.isPackForDelivery
                                                    ? 85
                                                    : 90,
                                                itemList: null
                                            );
                                            context.router.push(
                                                ScanPackForDeliveryRoute(
                                                    bookingStatus: bookingStatus,
                                                    isPackForDelivery: widget
                                                        .isPackForDelivery));
                                          },
                                          child: const Text(
                                            'Submit',
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.black),
                                          ))
                                    ]);
                              });
                        }

                    )

                )

            )

        )

    );
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
        }
    );
  }
}
