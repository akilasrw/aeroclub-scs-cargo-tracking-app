import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:provider/provider.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import '../../domain/data/booking_status.dart';
import '../../domain/data/cargo_booking_item.dart';
import '../../provider/common/status_update_provider.dart';
import '../../router/router.gr.dart';
import '../../utils/app_utils.dart';
import '../common/main_button.dart';
import '../common/main_text_field.dart';
import '../common/navbar.dart';

@RoutePage()
class ScanPackForDeliveryPage extends StatefulWidget {
  BookingStatus bookingStatus;
  bool isPackForDelivery;

  ScanPackForDeliveryPage({Key? key, required this.bookingStatus , required this.isPackForDelivery}) : super(key: key);

  @override
  State<ScanPackForDeliveryPage> createState() => _ScanPackForDeliveryPageState();
}

class _ScanPackForDeliveryPageState extends State<ScanPackForDeliveryPage> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  int scanCount = 0;
  final TextEditingController cargoController = TextEditingController();
  final TextEditingController consignmentNoManualController = TextEditingController();
  List<CargoBookingItem> bookingItems = [];
  List<String> scannedCargo = [];
  List<String> errorList = [];
  List<String> awbAssignedPackageList = List.empty();

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
                    HandoverWarehouseProvider()..getPreviousStatusPackages(widget.bookingStatus.awbNumber!,8,-1),
                    builder: (context, child) {
                      return Consumer<HandoverWarehouseProvider>(
                          builder: (da, data, child) {
                            return Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  left: 0,
                                  child: Navbar(title: "Scan Cargo",
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
                                            bookingItems.removeWhere((item) => item.packageItemId == res);
                                            bool removed = scannedCargo.remove(res);
                                            if(removed){
                                              setState(() {
                                                scannedCargo;
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
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: MainTextField(
                                                    labelText: 'Consignment No',
                                                    onValueChanged: (bool value) {},
                                                    controller: cargoController,
                                                    readOnly : true
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              InkWell(
                                                onTap: () async {
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
                                                              Icons.keyboard,
                                                              color :Colors.deepOrangeAccent,
                                                              size: 35.0,
                                                            ),
                                                            SizedBox(
                                                              width: 15,
                                                            ),

                                                            Text(
                                                              'Manual Entry',
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  color: Colors.white),

                                                            ),
                                                          ],
                                                        ),
                                                        content: MainTextField(
                                                          labelText: 'Consignment No',
                                                          onValueChanged: (bool value) {},
                                                          controller: consignmentNoManualController,
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: (){
                                                              if (consignmentNoManualController.text != null &&
                                                                  consignmentNoManualController.text != "" &&
                                                                  !scannedCargo.contains(consignmentNoManualController.text)) {
                                                                if(awbAssignedPackageList.contains(consignmentNoManualController.text)){
                                                                  scanCount++;
                                                                  cargoController.text = consignmentNoManualController.text!;
                                                                  CargoBookingItem bookingItem = CargoBookingItem(
                                                                      status: widget.isPackForDelivery ? 8 : 9,
                                                                      packageItemId: consignmentNoManualController.text!);
                                                                  bookingItems.add(bookingItem);
                                                                  scannedCargo.add(consignmentNoManualController.text!);
                                                                  FlutterBeep.beep();
                                                                  consignmentNoManualController.clear();
                                                                  Navigator.of(context).pop();
                                                                }
                                                                else{
                                                                  showAlert("Error", "Please unpack from ULD prior to delivery",false, onFailMethod);
                                                                }
                                                              }
                                                              else{
                                                                showAlert("Error", 'Invalid input',false, onFailMethod);
                                                              }
                                                            },
                                                            child: const Text('Ok',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors.redAccent),
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              consignmentNoManualController.clear();
                                                              Navigator.of(context).pop();
                                                            },
                                                            child: const Text('Cancel',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors.green),
                                                            ),
                                                          )
                                                        ],
                                                      ));
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
                                                    Icons.keyboard,
                                                    size: 25,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
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
                                            child: _buildQrView(context,data),
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

  Future<void> onSubmit(HandoverWarehouseProvider data) async {

    if(bookingItems != null && bookingItems.length > 0){
      BookingStatus? booking = widget.bookingStatus;
      booking?.itemList = bookingItems;
      booking.packageItemStatus = widget.isPackForDelivery ? 9 : 10;
      var isPacked = await data.handoverCargo(booking);
      if (isPacked) {
        showAlert("Success", "Cargo pick up successfully",true, redirectToHome);
      } else {
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

  Widget _buildQrView(BuildContext context,HandoverWarehouseProvider data) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    awbAssignedPackageList = data.packagesByStatus;
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
            !scannedCargo.contains(scanData.code) && !errorList.contains(scanData.code)) {
          if(awbAssignedPackageList.contains(scanData.code)){
            scanCount++;
            cargoController.text = scanData.code!;
            CargoBookingItem bookingItem = CargoBookingItem(
                status: widget.isPackForDelivery ? 9 : 10,
                packageItemId: scanData.code!);
            bookingItems.add(bookingItem);
            scannedCargo.add(scanData.code!);
            FlutterBeep.beep();
          }
          else{
            errorList.add(scanData.code!);
            showAlert("Error", "Please unpack from ULD prior to delivery",false, onFailMethod);
          }
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
