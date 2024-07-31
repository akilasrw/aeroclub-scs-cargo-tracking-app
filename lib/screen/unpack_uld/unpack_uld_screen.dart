import 'package:Cargo_Tracker/router/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../domain/data/flight.dart';
import '../../domain/data/load_uld.dart';
import '../../domain/data/uld_flight_schedule.dart';
import '../../utils/app_utils.dart';
import '../../utils/constants.dart';
import '../common/main_button.dart';
import '../common/navbar.dart';
import '../load_to_uld/uld_load_provider.dart';

@RoutePage()
class UnpackULDPage extends StatefulWidget {

  const UnpackULDPage({Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _UnpackULDPageState();
}

class _UnpackULDPageState extends State<UnpackULDPage> {
  Flight? flight = null;
  final TextEditingController dateController = TextEditingController();
  String? selectedUld = null;

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
                        ULDLoadProvider()..initProvider(false),
                    builder: (context, child) {
                      return Consumer<ULDLoadProvider>(
                          builder: (da, data, child) {
                        return Stack(
                          children: [
                            Positioned(
                              top: 0,
                              right: 0,
                              left: 0,
                              child: Navbar(
                                  title:"Unpack ULD"),
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
                                          items: data.flightList
                                              .map<DropdownMenuItem<Flight>>(
                                                  (Flight value) {
                                            return DropdownMenuItem<Flight>(
                                              value: value,
                                              child: Text(value.flightNumber),
                                            );
                                          }).toList(),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        DateTimeField(
                                          format: DateFormat("yyyy-MM-dd"),
                                          onChanged: (value ){
                                              if(flight != null){
                                                  var uldFlightSchedule = ULDFlightSchedule(
                                                      flightNumber : flight!.flightNumber,
                                                      scheduledDepartureDateTime : dateController.text
                                                  );
                                                  data.getULDs(uldFlightSchedule);
                                              }
                                          },
                                          controller: dateController,
                                          textAlign: TextAlign.left,
                                          maxLines: 1,
                                          initialValue: new DateTime.now(),
                                          onShowPicker:
                                              (context, currentValue) {
                                            return showDatePicker(
                                                context: context,
                                                firstDate: DateTime(2024),
                                                initialDate: currentValue ??
                                                    DateTime.now(),
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
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 8),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white),
                                              ),
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white),
                                              ),
                                              hintText: 'Flight Date',
                                              hintStyle: TextStyle(
                                                  color: const Color(0xFF001C31)
                                                      .withOpacity(0.6),
                                                  fontSize: 14),
                                              prefixIcon: Icon(
                                                Icons.date_range,
                                                color: Colors.black,
                                              )),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        DropdownButtonFormField<String>(
                                                isExpanded: true,
                                                icon: const Icon(Icons
                                                    .arrow_drop_down_circle_rounded),
                                                elevation: 16,
                                                style: const TextStyle(
                                                    color: Color(0xFF001C31)),
                                                decoration:
                                                    dropdownDecoration.copyWith(
                                                        hintText: "ULD No"),
                                                onChanged: (String? value) {
                                                  // This is called when the user selects an item.
                                                  setState(() {
                                                    selectedUld = value!;
                                                  });
                                                },
                                                items: data.uldSerialNumberList.map<
                                                        DropdownMenuItem<
                                                            String>>(
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
                                          AppUtils.showAlert(
                                              context,
                                              'Error',
                                              "Please select a flight",
                                              false, () {
                                            Navigator.of(context).pop();
                                          });
                                          return;
                                        }
                                        if (dateController.text.isEmpty) {
                                          AppUtils.showAlert(
                                              context,
                                              'Error',
                                              "Please add flight date",
                                              false, () {
                                            Navigator.of(context).pop();
                                          });
                                          return;
                                        }
                                        if (selectedUld == null) {
                                          AppUtils.showAlert(
                                              context,
                                              'Error',
                                              "Please add uld number",
                                              false, () {
                                            Navigator.of(context).pop();
                                          });
                                          return;
                                        }
                                        var loadULD = LoadULD(
                                            flightID: flight?.flightId,
                                            scheduledDepartureDateTime:
                                                dateController.text,
                                            uldSerialNumber: selectedUld,
                                            uld: selectedUld,
                                            packageIDs: null);
                                        context.router.push(ScanUnpackULDCargoRoute(
                                            loadULD: loadULD));
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
                                              context.router.push(HomeRoute());
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
