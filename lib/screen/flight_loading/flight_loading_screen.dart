import 'dart:convert';

import 'package:Cargo_Tracker/domain/data/booking.dart';
import 'package:Cargo_Tracker/domain/data/uld_flight_schedule.dart';
import 'package:Cargo_Tracker/router/router.gr.dart';
import 'package:Cargo_Tracker/screen/pickup_cargo/scan_cargo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../domain/data/flight.dart';
import 'flight_loading_provider.dart';

@RoutePage()
class FlightLoadingPage extends StatefulWidget {
  final bool isFlightLoading;

  const FlightLoadingPage({Key? key, required this.isFlightLoading})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PickUpCargoMainDetailsState();
}

class _PickUpCargoMainDetailsState extends State<FlightLoadingPage> {
  String result = '';
  Flight? flight = null;
  final TextEditingController dateController = TextEditingController();

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(
              widget.isFlightLoading ? "Flight Loading" : "Flight Unloading"),
        ),
        body: Center(
            child: Container(
                margin: const EdgeInsets.all(30.0),
                child: ChangeNotifierProvider(
                    create: (BuildContext context) =>
                        FlightLoadingProvider()..initProvider(),
                    builder: (context, child) {
                      return Consumer<FlightLoadingProvider>(
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
                                    .headline6
                                    ?.copyWith(color: Colors.black),
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(8),
                                    border: OutlineInputBorder(),
                                    labelText: 'Flight Date',
                                    prefixIcon: Icon(
                                      Icons.date_range,
                                      color: Colors.black,
                                    )),
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
                                    var uldFlightSchedule = ULDFlightSchedule(
                                        flightNumber : flight!.value,
                                        scheduledDepartureDateTime : dateController.text
                                    );
                                    context.router.push(LoadULDToFlightRoute(uldFlightSchedule: uldFlightSchedule,
                                        isFlightLoading: widget.isFlightLoading));
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
}
