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
import '../../domain/data/package_filter/package_filter_res.dart';
import '../../provider/common/status_update_provider.dart';
import '../../router/router.gr.dart';
import '../../utils/app_utils.dart';
import '../../utils/constants.dart';
import '../common/main_button.dart';
import '../common/main_text_field.dart';
import '../common/navbar.dart';

@RoutePage()
class UpdateOffloadedCargoPage extends StatefulWidget {
  BookingStatus bookingStatus;
  UpdateOffloadedCargoPage({Key? key,required this.bookingStatus}) : super(key: key);

  @override
  State<UpdateOffloadedCargoPage> createState() => _UpdateOffloadedCargoPageState();
}

class _UpdateOffloadedCargoPageState extends State<UpdateOffloadedCargoPage> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  int scanCount = 0;
  List<String> scannedCargo = [];
  final TextEditingController cargoController = TextEditingController();
  final TextEditingController consignmentNoManualController = TextEditingController();
  List<CargoBookingItem> bookingItems = [];
  String? type = "Offload";
  List<String> typeList = ["Offload", "Return"];
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
                  title: Text(
                      'Scanned $scannedLength packages will be discarded. '
                          'Do you want to continue?'),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          willLeave = true;
                          Navigator.of(context).pop();
                        },
                        child: const Text('Yes')),
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('No'))
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
                    HandoverWarehouseProvider()..getPreviousStatusPackages(widget.bookingStatus.awbNumber!,4,3),
                    builder: (context, child) {
                      return Consumer<HandoverWarehouseProvider>(
                          builder: (da, data, child) {
                            return Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  left: 0,
                                  child: Navbar(title: "Offload / Return Cargo",
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
                                          Column(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 20, vertical: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  color: Colors.white,
                                                ),
                                                child:
                                                DropdownButtonFormField<String>(
                                                  isExpanded: true,
                                                  icon: const Icon(Icons
                                                      .arrow_drop_down_circle_rounded),
                                                  elevation: 16,
                                                  style: const TextStyle(
                                                      color: Colors.deepPurple),
                                                  decoration: dropdownDecoration
                                                      .copyWith(hintText: "Type"),
                                                  onChanged: (String? value) {
                                                    setState(() {
                                                      type = value;
                                                    });
                                                  },
                                                  value: type,
                                                  items: typeList.map<
                                                      DropdownMenuItem<String>>(
                                                          (String value) {
                                                        return DropdownMenuItem<String>(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList(),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Container(
                                                  padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(10),
                                                    color: Colors.white,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(Icons.north_east,
                                                              color:
                                                              Colors.black87),
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
                                                  )),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                            ],
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
                                                              if (!scannedCargo.contains(consignmentNoManualController.text)) {

                                                                if (consignmentNoManualController.text != null &&
                                                                    consignmentNoManualController.text != "") {
                                                                  if(awbAssignedPackageList.contains(consignmentNoManualController.text)){
                                                                    scanCount++;
                                                                    cargoController.text = consignmentNoManualController.text!;
                                                                    scannedCargo.add(consignmentNoManualController.text!);
                                                                    CargoBookingItem bookingItem = CargoBookingItem(
                                                                        status: type == "Offload" ? 4 : 1, packageItemId: consignmentNoManualController.text!);
                                                                    bookingItems.add(bookingItem);
                                                                    FlutterBeep.beep();
                                                                    consignmentNoManualController.clear();
                                                                    Navigator.of(context).pop();
                                                                  }
                                                                  else{
                                                                    showAlert("Error", "This package is not in the system",false, onFailMethod);
                                                                  }
                                                                }
                                                                else{
                                                                  showAlert("Error", 'Invalid input',false, onFailMethod);
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
                                              child: const Icon(
                                                Icons.home_outlined,
                                                color: Colors.blue,
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
    if(bookingItems != null && bookingItems.isNotEmpty){
      BookingStatus? booking = widget.bookingStatus;
      booking?.itemList = bookingItems;
      booking.packageItemStatus = type == "Offload" ? 5 : 2;
      var isPacked = await data.handoverCargo(booking);

      if (isPacked) {
        showAlert("Success", "Cargo "+type!+" successfully",true, redirectToHome);
      } else {
        showAlert("Error", "Something went wrong",false, onFailMethod);
      }
    }
    else{
      AppUtils.showAlert(context,'Error',"no packages has scanned.",false,() {
        Navigator.of(context).pop();
      });
    }
  }

  void showAlert(String title, String msg,bool isSuccess, Function() function) {
    AppUtils.showAlert(context, title, msg, isSuccess, function);
  }

  void redirectToHome() {
    context.router.push(const HomeRoute());
  }

  void onFailMethod() {
    Navigator.of(context).pop();
  }

  void validateScannedCargo(List<PackageFilterRes> bookedPackageItems) {
    if (bookedPackageItems.length != bookingItems.length) {}
    for (PackageFilterRes package in bookedPackageItems) {
      if (bookingItems.contains(package.packageRefNumber)) {}
    }
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
          if(awbAssignedPackageList.contains(scanData.code) ){
            scanCount++;
            cargoController.text = scanData.code!;
            scannedCargo.add(scanData.code!);
            CargoBookingItem bookingItem = CargoBookingItem(
                status: type == "Offload" ? 4 : 1, packageItemId: scanData.code!);
            bookingItems.add(bookingItem);
            FlutterBeep.beep();
          }
          else{
            errorList.add(scanData.code!);
            showAlert("Error", "This package is not in the system",false, onFailMethod);
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

  void _showError(String errorMsg){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 5),
          content: Text(errorMsg),
        )
    );
  }
}
