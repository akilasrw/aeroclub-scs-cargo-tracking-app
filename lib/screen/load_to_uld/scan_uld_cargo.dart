import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:provider/provider.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import '../../domain/data/load_uld.dart';
import '../../router/router.gr.dart';
import '../../utils/app_utils.dart';
import '../common/main_button.dart';
import '../common/main_text_field.dart';
import '../common/navbar.dart';
import 'package:Cargo_Tracker/domain/data/booking.dart';

import '../load_to_uld/uld_load_provider.dart';
import '../pickup_cargo/provider.dart';

@RoutePage()
class ScanULDCargoPage extends StatefulWidget {
  LoadULD loadULD;
  final bool isCargoLoading;

  ScanULDCargoPage({Key? key, required this.loadULD , required this.isCargoLoading}) : super(key: key);

  @override
  State<ScanULDCargoPage> createState() => _ScanULDCargoPageState();
}

class _ScanULDCargoPageState extends State<ScanULDCargoPage> {

  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  int scanCount = 0;
  final TextEditingController cargoController = TextEditingController();
  List<String> bookingItems = [];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: () async {
          bool willLeave = false;
          // show the confirm dialog
          if (bookingItems.isNotEmpty) {
            String scannedLength = bookingItems.length.toString();
            await showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      side: BorderSide(color: Color(0xFF032F50))
                  ),
                  backgroundColor: const Color(0xFF001C31),
                  title: Row(
                    children: [
                      Icon(
                        Icons.warning_amber,
                        color :Colors.deepOrangeAccent,
                        size: 35.0,
                      ),
                      SizedBox(
                        width: 15,
                      ),

                      Text(
                        'Warning',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white),

                      ),
                    ],
                  ),
                  content: Text('Scanned $scannedLength packages will be discarded. '
                      'Do you want to continue?',style: TextStyle(color: Colors.white70),),
                  actions: [
                    TextButton(
                      onPressed: (){
                        willLeave = true;
                        Navigator.of(context).pop();
                      },
                      child: const Text('YES',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.redAccent),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('NO',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.green),
                      ),
                    )
                  ],
                ));
          } else {
            willLeave = true;
          }
          return willLeave;
        },
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            backgroundColor: const Color(0xFF001C31),
            body: SafeArea(
                child: ChangeNotifierProvider(
                    create: (BuildContext context) =>
                    ULDLoadProvider()..initProvider(),
                    builder: (context, child) {
                      return Consumer<ULDLoadProvider>(
                          builder: (da, data, child) {
                            return Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  left: 0,
                                  child: Navbar(title: "Scan ULD Cargo",
                                      isDeleteButtonRequired: true,
                                      onDeleteButtonClicked: () async {
                                        var res = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                              const SimpleBarcodeScannerPage(),
                                            ));

                                        if (res is String && res != '-1') {
                                          AppUtils.confirmDeletion(context,res, (){
                                            bool removed = bookingItems.remove(res);
                                            if(removed){
                                              setState(() {
                                                bookingItems;
                                                scanCount--;
                                              });
                                            }
                                            Navigator.of(context).pop();
                                          });
                                        }

                                      }),
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  top: 80,
                                  bottom: 50,
                                  child: SingleChildScrollView(
                                    physics: const AlwaysScrollableScrollPhysics(),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              color: Colors.white,
                                            ),
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(Icons.north_east,
                                                            color: Colors.black87),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          "Scanned Count",
                                                          style: TextStyle(
                                                              color:
                                                              Colors.black54),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      "$scanCount",
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          color: Colors.black,
                                                          fontSize: 20),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          MainTextField(
                                            labelText: 'Consignment No',
                                            onValueChanged: (bool value) {},
                                            controller: cargoController,
                                            readOnly : true
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            width: width,
                                            height: width - 40,
                                            // padding: EdgeInsets.symmetric(horizontal: width * .2, vertical: (width-40) *.2),
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                              BorderRadius.circular(10),
                                            ),
                                            child: _buildQrView(context),
                                          ),
                                        ],
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
                                            horizontal: 15, vertical: 5),
                                        child: data.isLoading
                                            ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                            : MainButton(
                                          title: 'DONE',
                                          onTapped: () {
                                            onSubmit(data);
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
                    })),
          ),
        ));
  }

  Future<void> onSubmit(ULDLoadProvider data) async {
    if(bookingItems != null && bookingItems.length > 0){
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
        showAlert("Success", "ULD "+ (widget.isCargoLoading ? "packed" : "unpacked")+" successfully",true,redirectToHome);
      }
      else{
        showAlert("Error", "Something went wrong",false, onFailMethod);
      }
    }
    else{
      showAlert("Error", "No packages has scanned",false, onFailMethod);
    }
  }

  void showAlert(String title, String msg,bool isSuccess, Function() function) {
    AppUtils.showAlert(context, title, msg,isSuccess, function);
  }

  void redirectToHome() {
    context.router.push(const HomeRoute());
  }

  void onFailMethod() {
    Navigator.of(context).pop();
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
            borderColor: Colors.red,
            borderRadius: 10,
            borderLength: 30,
            borderWidth: 10,
            cutOutSize: scanArea),
        onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p));
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        if (scanData.code is String &&
            scanData.code != null &&
            !bookingItems.contains(scanData.code)) {
          scanCount++;
          cargoController.text = scanData.code!;
          bookingItems.add(scanData.code!);
          FlutterBeep.beep();
        }
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
