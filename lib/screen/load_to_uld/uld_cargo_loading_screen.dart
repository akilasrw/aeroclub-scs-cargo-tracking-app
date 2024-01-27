import 'dart:convert';

import 'package:Cargo_Tracker/domain/data/load_uld.dart';
import 'package:Cargo_Tracker/router/router.gr.dart';
import 'package:Cargo_Tracker/screen/load_to_uld/uld_load_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../domain/data/flight.dart';

@RoutePage()
class ULDCargoLoadingPage extends StatefulWidget {
  final bool isCargoLoading;

  const ULDCargoLoadingPage({Key? key, required this.isCargoLoading})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PickUpCargoMainDetailsState();
}

class _PickUpCargoMainDetailsState extends State<ULDCargoLoadingPage> {
  String result = '';
  final TextEditingController uldNumberController = TextEditingController();
  Flight? flight = null;
  final TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(
              widget.isCargoLoading ? "Pack Cargo to ULD" : "Unload ULD Cargo"),
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
                              DropdownButtonFormField<Flight>(
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
                                  labelText: 'Flight No',
                                ),
                                onChanged: (Flight? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    flight = value!;
                                  });
                                },
                                items: data.flightList.map<DropdownMenuItem<Flight>>(
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
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(8),
                                    border: OutlineInputBorder(),
                                    labelText: 'Date',
                                    prefixIcon: Icon(
                                      Icons.date_range,
                                      color: Colors.black,
                                    )),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                style: TextStyle(color: Colors.black45),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.teal)),
                                  labelText: 'ULD Number',
                                ),
                                controller: uldNumberController,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    minimumSize:
                                        const Size.fromHeight(50), // NEW
                                  ),
                                  onPressed: () {
                                    if (uldNumberController.text.isEmpty) {
                                      showAlert("Please add ULD number");
                                      return;
                                    }
                                    if (dateController.text.isEmpty) {
                                      showAlert("Please add flight date");
                                      return;
                                    }
                                    if (flight == null) {
                                      showAlert("Please select a flight");
                                      return;
                                    }
                                    var loadULD = LoadULD(
                                        flightID:flight?.id,
                                        scheduledDepartureDateTime : dateController.text,
                                        uldSerialNumber: uldNumberController.text,
                                        uld : uldNumberController.text,
                                        packageIDs: null
                                    );
                                    context.router.push(ScanULDCargoRoute(loadULD: loadULD,
                                    isCargoLoading: widget.isCargoLoading));
                                  },
                                  child: const Text(
                                    'Submit',
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.black),
                                  ))
                            ]);
                      });
                    }))));
  }

  void showAlert(String msg) {
    showDialog(
        context: context,
        builder : (BuildContext context){
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
        }
    );
  }
}
