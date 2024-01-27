import 'package:Cargo_Tracker/domain/data/booking.dart';
import 'package:Cargo_Tracker/domain/data/cargo_booking_item.dart';
import 'package:Cargo_Tracker/screen/pickup_cargo/provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ScanCargoPage extends StatefulWidget {
  Booking booking;

  ScanCargoPage({Key? key, required this.booking}) : super(key: key);

  @override
  State<ScanCargoPage> createState() => _ScanCargoState();
}

class _ScanCargoState extends State<ScanCargoPage> {
  int scanCount = 0;
  final TextEditingController cargoController = TextEditingController();
  List<String> bookingItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
          title: const Text("Scan Cargo"),
        ),
        body: Center(
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Scanned count : $scanCount",
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30)),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(
                                            flex: 8,
                                            child: TextField(
                                                controller: cargoController,
                                                style: TextStyle(color: Colors.black45),
                                                decoration: const InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderSide:
                                                      BorderSide(
                                                          color: Colors.teal)),
                                                  labelText: 'Consignment No',
                                                ))),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Material(
                                            type: MaterialType.transparency,
                                            child: Ink(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.indigoAccent,
                                                    width: 3.0),
                                                color: Colors.indigo[900],
                                                shape: BoxShape.circle,
                                              ),
                                              child: InkWell(
                                                //This keeps the splash effect within the circle
                                                borderRadius: BorderRadius
                                                    .circular(1000.0),
                                                //Something large to ensure a circle
                                                onTap: () async {
                                                  var res = await Navigator
                                                      .push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                        const SimpleBarcodeScannerPage(),
                                                      ));
                                                  setState(() {
                                                    if (res is String) {
                                                      scanCount++;
                                                      cargoController.text =
                                                          res;
                                                      //CargoBookingItem bookingItem =  CargoBookingItem(packageItemStatus: 1,packageRefNumber: res);
                                                      bookingItems.add(res);
                                                    }
                                                  });
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.all(15.0),
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
                                    height: 40,
                                  ),
                                  data.isLoading ?
                                  const Center(
                                    child: CircularProgressIndicator(),
                                  ) :
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        minimumSize: const Size.fromHeight(
                                            50), // NEW
                                      ),
                                      onPressed: () {
                                        Booking? booking = widget.booking;
                                        booking?.packages = bookingItems;
                                        data.pickupCargo(context,booking);
                                      },
                                      child: const Text(
                                        'Finalize Truck',
                                        style: TextStyle(
                                            fontSize: 24, color: Colors.black),
                                      ))
                                ]);
                          });
                    })


            )));
  }
}
