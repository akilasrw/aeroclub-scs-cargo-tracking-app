import 'package:Cargo_Tracker/router/router.gr.dart';
import 'package:Cargo_Tracker/screen/pickup_cargo/provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import '../../domain/data/booking_status.dart';
import 'package:provider/provider.dart';
import '../../utils/app_utils.dart';
import '../common/main_button.dart';
import '../common/main_text_field.dart';
import '../common/navbar.dart';

@RoutePage()
class OffloadCargoMainDetailsPage extends StatefulWidget {
  const OffloadCargoMainDetailsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OffloadCargoMainDetailsPageState();
}

class _OffloadCargoMainDetailsPageState extends State<OffloadCargoMainDetailsPage> {
  String result = '';
  final TextEditingController awbController = TextEditingController();

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
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  left: 0,
                                  child: Navbar(title: "Offload / Return Cargo"),
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
                                            if (awbController.text.isEmpty) {
                                              AppUtils.showAlert(context,'Error',"Please add AWB number",false,() {
                                                Navigator.of(context).pop();
                                              });
                                              return;
                                            }
                                            if (awbController.text.length != 11) {
                                              AppUtils.showAlert(context,'Error',"AWB number should contain 11 numbers.",false,() {
                                                Navigator.of(context).pop();
                                              });
                                              return;
                                            }
                                            var bookingStatus = BookingStatus(
                                                awbNumber:
                                                int.parse(awbController.text),
                                                itemList: null
                                            );
                                            context.router.push(UpdateOffloadedCargoRoute(bookingStatus: bookingStatus));
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
}
