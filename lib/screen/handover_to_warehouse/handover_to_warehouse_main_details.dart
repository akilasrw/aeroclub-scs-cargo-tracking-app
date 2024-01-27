import 'dart:convert';

import 'package:Cargo_Tracker/domain/data/booking.dart';
import 'package:Cargo_Tracker/domain/data/booking_status.dart';
import 'package:Cargo_Tracker/router/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

@RoutePage()
class HandoverToWarehouseMainDetailsPage extends StatefulWidget {
  const HandoverToWarehouseMainDetailsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PickUpCargoMainDetailsState();
}

class _PickUpCargoMainDetailsState extends State<HandoverToWarehouseMainDetailsPage> {
  String result = '';
  final TextEditingController awbController = TextEditingController();
  final TextEditingController truckController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Handover to Warehouse"),
        ),
        body: Center(
            child: Container(
                margin: const EdgeInsets.all(30.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        style: TextStyle(color: Colors.black45),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal)),
                          labelText: 'Truck Number',
                        ),
                        controller: truckController,
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
                                    style: TextStyle(color: Colors.black45),
                                    controller: awbController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Colors.teal)),
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
                                        color: Colors.indigoAccent, width: 3.0),
                                    color: Colors.indigo[900],
                                    shape: BoxShape.circle,
                                  ),
                                  child: InkWell(
                                    //This keeps the splash effect within the circle
                                    borderRadius: BorderRadius.circular(1000.0),
                                    //Something large to ensure a circle
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
                                    child: Padding(
                                      padding: EdgeInsets.all(15.0),
                                      child: Icon(
                                        Icons.document_scanner_outlined,
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
                            minimumSize: const Size.fromHeight(50), // NEW
                          ),
                          onPressed: () {
                            if (truckController.text.isEmpty) {
                              showAlert("Please add truck number");
                              return;
                            }
                            if (awbController.text.isEmpty) {
                              showAlert("Please add awb number");
                              return;
                            }
                             var bookingStatus = BookingStatus(
                               awbNumber:
                               int.parse(awbController.text),
                               truckNo: truckController.text,
                               status: 30,
                               itemList: null
                             );
                             context.router.push(ScanAcceptCargoRoute(bookingStatus: bookingStatus));
                          },
                          child: const Text(
                            'Submit',
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ))
                    ]))));
  }

  void showAlert(String msg) {
    showDialog(
        context: context,
        builder : (BuildContext context){
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
