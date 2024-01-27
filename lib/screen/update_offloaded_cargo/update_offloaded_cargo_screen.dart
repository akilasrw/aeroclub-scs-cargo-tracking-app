import 'package:provider/provider.dart';
import 'package:Cargo_Tracker/domain/data/cargo_booking_item.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../domain/data/booking_status.dart';
import '../../provider/common/status_update_provider.dart';

@RoutePage()
class UpdateOffloadedCargoPage extends StatefulWidget {
  UpdateOffloadedCargoPage({Key? key}) : super(key: key);

  @override
  State<UpdateOffloadedCargoPage> createState() => _ScanCargoState();
}

class _ScanCargoState extends State<UpdateOffloadedCargoPage> {
  int scanCount = 0;
  final TextEditingController cargoController = TextEditingController();
  List<CargoBookingItem> bookingItems = [];
  String? type = "Offload";
  List<String> typeList = ["Offload", "Return"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Offload / Return Cargo"),
        ),
        body: Center(
            child: Container(
                margin: const EdgeInsets.all(30.0),
                child: ChangeNotifierProvider(
                    create: (BuildContext context) =>
                        HandoverWarehouseProvider()..initProvider(),
                    builder: (context, child) {
                      return Consumer<HandoverWarehouseProvider>(
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
                              DropdownButtonFormField<String>(
                                isExpanded: true,
                                icon: const Icon(
                                    Icons.arrow_drop_down_circle_rounded),
                                elevation: 16,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.teal)),
                                  labelText: 'Type',
                                ),
                                onChanged: (String? value) {
                                  setState(() {
                                    type = value;
                                  });
                                },
                                items: typeList.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
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
                                            controller: cargoController,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
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
                                            borderRadius:
                                                BorderRadius.circular(1000.0),
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
                                                  scanCount++;
                                                  cargoController.text = res;
                                                  CargoBookingItem bookingItem =
                                                  CargoBookingItem(
                                                      status: type == "Offload" ? 6 : 5,
                                                      packageItemId:
                                                      res);
                                                   bookingItems.add(bookingItem);
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
                                height: 40,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    minimumSize:
                                        const Size.fromHeight(50), // NEW
                                  ),
                                  onPressed: () {
                                    BookingStatus? booking = BookingStatus(itemList:bookingItems );
                                    data.handoverCargo(booking);
                                  },
                                  child: const Text(
                                    'Done',
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.black),
                                  ))
                            ]);
                      });
                    }))));
  }
}
