import 'package:Cargo_Tracker/router/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../domain/data/flight.dart';
import '../../domain/data/load_uld.dart';
import '../../utils/app_utils.dart';
import '../../utils/constants.dart';
import '../common/main_button.dart';
import '../common/main_text_field.dart';
import '../common/navbar.dart';
import '../load_to_uld/uld_load_provider.dart';

@RoutePage()
class ULDCargoLoadingPage extends StatefulWidget {
  final bool isCargoLoading;
  const ULDCargoLoadingPage({Key? key, required this.isCargoLoading}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ULDCargoLoadingPageState();
}

class _ULDCargoLoadingPageState extends State<ULDCargoLoadingPage> {
  final TextEditingController uldNumberController = TextEditingController();
  Flight? flight = null;
  final TextEditingController dateController = TextEditingController();
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
                                  child: Navbar(title: widget.isCargoLoading ? "Pack ULD" : "Unpack ULD"),
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
                                            DropdownButtonFormField<Flight>(
                                              isExpanded: true,
                                              icon: const Icon(Icons
                                                  .arrow_drop_down_circle_rounded),
                                              elevation: 16,
                                              style: const TextStyle(
                                                  color: Color(0xFF001C31)),
                                              decoration: dropdownDecoration
                                                  .copyWith(hintText: "Flight No"),
                                              onChanged: (Flight? value) {
                                                // This is called when the user selects an item.
                                                setState(() {
                                                  flight = value!;
                                                });
                                              },
                                              items: data.flightList.map<
                                                  DropdownMenuItem<Flight>>(
                                                      (Flight value) {
                                                    return DropdownMenuItem<Flight>(
                                                      value: value,
                                                      child: Text(value.value),
                                                    );
                                                  }).toList(),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            DateTimeField(
                                              format: DateFormat("yyyy-MM-dd"),
                                              controller: dateController,
                                              textAlign: TextAlign.left,
                                              maxLines: 1,
                                              initialValue: new DateTime.now(),
                                              onShowPicker: (context, currentValue) {
                                                return showDatePicker(
                                                    context: context,
                                                    firstDate: DateTime(1900),
                                                    initialDate:
                                                    currentValue ?? DateTime.now(),
                                                    lastDate: DateTime(2100));
                                              },
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(color: Colors.black),
                                              decoration: InputDecoration(
                                                  fillColor: Colors.white,
                                                  alignLabelWithHint: true,
                                                  filled: true,
                                                  isDense: true,
                                                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.white),
                                                  ),
                                                  disabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.white),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.white),
                                                  ),
                                                  hintText: 'Flight Date',
                                                  hintStyle: TextStyle(
                                                      color: const Color(0xFF001C31).withOpacity(0.6), fontSize: 14),
                                                  prefixIcon: Icon(
                                                    Icons.date_range,
                                                    color: Colors.black,
                                                  )
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: MainTextField(
                                                    labelText: 'ULD Number',
                                                    onValueChanged: (bool value) {},
                                                    controller: uldNumberController,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
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
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
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
                                            if (flight == null) {
                                              AppUtils.showAlert(context,'Error',"Please select a flight",false,() {
                                                Navigator.of(context).pop();
                                              });
                                              return;
                                            }
                                            if (dateController.text.isEmpty) {
                                              AppUtils.showAlert(context,'Error',"Please add flight date",false,() {
                                                Navigator.of(context).pop();
                                              });
                                              return;
                                            }
                                            if (uldNumberController.text.isEmpty) {
                                              AppUtils.showAlert(context,'Error',"Please add uld number",false,() {
                                                Navigator.of(context).pop();
                                              });
                                              return;
                                            }
                                            if (awbController.text.isEmpty) {
                                              AppUtils.showAlert(context,'Error',"Please add awb number",false,() {
                                                Navigator.of(context).pop();
                                              });
                                              return;
                                            }
                                            var loadULD = LoadULD(
                                                flightID:flight?.id,
                                                scheduledDepartureDateTime : dateController.text,
                                                uldSerialNumber: uldNumberController.text,
                                                uld : uldNumberController.text,
                                                awbNumber: awbController.text,
                                                packageIDs: null
                                            );
                                            context.router.push(ScanULDCargoRoute(loadULD: loadULD,
                                                isCargoLoading: widget.isCargoLoading));
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
        });
  }
}
