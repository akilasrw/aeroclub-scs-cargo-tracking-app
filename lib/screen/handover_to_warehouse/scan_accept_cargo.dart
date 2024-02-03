import 'dart:convert';

import 'package:Cargo_Tracker/domain/data/booking.dart';
import 'package:Cargo_Tracker/domain/data/cargo_booking_item.dart';
import 'package:Cargo_Tracker/provider/common/status_update_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../domain/data/booking_status.dart';
import '../../domain/data/package_filter/package_filter_res.dart';
import '../../router/router.gr.dart';
import '../../utils/app_utils.dart';

@RoutePage()
class ScanAcceptCargoPage extends StatefulWidget {
  BookingStatus bookingStatus;

  ScanAcceptCargoPage({Key? key, required this.bookingStatus}) : super(key: key);

  @override
  State<ScanAcceptCargoPage> createState() => _ScanCargoState();
}

class _ScanCargoState extends State<ScanAcceptCargoPage> {
  int scanCount = 0;
  int originalPackageCount = 0;
  final TextEditingController cargoController = TextEditingController();
  List<CargoBookingItem> bookingItems = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Scan Cargo"),
        ),
        body: Center(
            child: Container(
                margin: const EdgeInsets.all(30.0),
                child: ChangeNotifierProvider(
                    create: (BuildContext context) =>
                        HandoverWarehouseProvider()..loadScannedPackages(widget.bookingStatus.awbNumber!),
                    builder: (context, child) {
                      return Consumer<HandoverWarehouseProvider>(
                          builder: (da, data, child) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  "Original Package Count : ${data.bookedPackageItems.length}",
                                  style: TextStyle(
                                      color: Colors.grey[800],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25)),
                              SizedBox(
                                height: 30,
                              ),
                              Text("Scanned count : $scanCount",
                                  style: TextStyle(
                                      color: Colors.blue[900],
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
                                            style: TextStyle(color: Colors.black45),
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
                                                          status: 1,
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
                              data.isLoading ?
                              const Center(
                                child: CircularProgressIndicator(),
                              ) :
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    minimumSize:
                                        const Size.fromHeight(50), // NEW
                                  ),
                                  onPressed: () {
                                    //validateScannedCargo(data.bookedPackageItems);
                                    onSubmit(data);
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

  Future<void> onSubmit(HandoverWarehouseProvider data) async {
    BookingStatus? booking = widget.bookingStatus;
    booking?.itemList = bookingItems;
    data.handoverCargo(booking);
    var isPacked = await data.handoverCargo(booking);
    if(isPacked){
      showAlert("Success", "Cargo handover successfully",redirectToHome);
    }
    else{
      showAlert("Error", "Something went wrong", onFailMethod);
    }
  }

  void showAlert(String title, String msg , Function() function){
    AppUtils.showAlert(context, title, msg,function);
  }
  void redirectToHome(){
    context.router.push(const HomeRoute());
  }

  void onFailMethod(){
    Navigator.of(context).pop();
  }

  void validateScannedCargo(List<PackageFilterRes> bookedPackageItems){
    if(bookedPackageItems.length != bookingItems.length){

    }
    for(PackageFilterRes package in bookedPackageItems){
      if(bookingItems.contains(package.packageRefNumber)){

      }
    }
  }
}
