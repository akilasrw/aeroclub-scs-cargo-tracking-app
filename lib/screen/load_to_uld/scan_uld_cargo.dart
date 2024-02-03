import 'package:provider/provider.dart';
import 'package:Cargo_Tracker/screen/load_to_uld/uld_load_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../domain/data/load_uld.dart';
import '../../router/router.gr.dart';
import '../../utils/app_utils.dart';

@RoutePage()
class ScanULDCargoPage extends StatefulWidget {
  LoadULD loadULD;
  final bool isCargoLoading;
  ScanULDCargoPage({Key? key, required this.loadULD , required this.isCargoLoading}) : super(key: key);

  @override
  State<ScanULDCargoPage> createState() => _ScanCargoState();
}

class _ScanCargoState extends State<ScanULDCargoPage> {
  int scanCount = 0;
  final TextEditingController cargoController = TextEditingController();
  List<String> bookingItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Scan ULD Cargo"),
        ),
        body: Center(
            child: Container(
                margin: const EdgeInsets.all(30.0),
                child: ChangeNotifierProvider(
                    create: (BuildContext context) =>
                    ULDLoadProvider()..initProvider(),
                    builder: (context, child) {
                      return Consumer<ULDLoadProvider>(
                          builder: (da, data, child) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(widget.isCargoLoading ? "Packed count : $scanCount" : "Unpacked count : $scanCount",
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
                                                  // CargoBookingItem bookingItem =
                                                  // CargoBookingItem(packageItemStatus: 1,packageRefNumber: res);
                                                  bookingItems.add(res);
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
                                    onSubmit(data);
                                  },
                                  child: Text(
                                    widget.isCargoLoading ? 'Finalize ULD' : 'Unpack Complete',
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.black),
                                  ))
                            ]);
                      });
                    }))));
  }

  Future<void> onSubmit(ULDLoadProvider data) async {
    bool isPacked = false;
    if(widget.isCargoLoading){
      LoadULD? loadUld = widget.loadULD;
      loadUld?.packageIDs = bookingItems;
      isPacked = await data.packToULD(loadUld);

    }
    else{
      LoadULD? loadUld = widget.loadULD;
      loadUld?.packageIDs = bookingItems;
      isPacked = await data.unpackToULD(loadUld);
    }
    if(isPacked){
      showAlert("Success", "ULD packed successfully",redirectToHome);
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
}
