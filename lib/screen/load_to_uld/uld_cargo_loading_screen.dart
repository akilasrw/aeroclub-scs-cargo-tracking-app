import 'dart:convert';

import 'package:Cargo_Tracker/domain/data/booking.dart';
import 'package:Cargo_Tracker/router/router.gr.dart';
import 'package:Cargo_Tracker/screen/pickup_cargo/scan_cargo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../domain/data/flight.dart';


@RoutePage()
class ULDCargoLoadingPage extends StatefulWidget {
  final bool isCargoLoading;
  const ULDCargoLoadingPage({Key? key,required this.isCargoLoading}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PickUpCargoMainDetailsState();
}

class _PickUpCargoMainDetailsState extends State<ULDCargoLoadingPage> {
  String result = '';
  final TextEditingController uldNumberController = TextEditingController();
  List<Flight> list = List.empty();
  Flight? flight = null;
  final TextEditingController dateController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getFlightNumbers();
  }
  List<Flight> parseFlights(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Flight>((json) =>Flight.fromMap(json)).toList();
  }

  Future<List<Flight>?> getFlightNumbers() async {
    try {
      var url = Uri.parse("https://aeroclub-skytechcargo-app-dev-002.azurewebsites.net/api/v1/airport/getSelectList");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          list = parseFlights(response.body);
        });
      }
    } catch (e) {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.isCargoLoading ? "Pack Cargo to ULD" : "Unload ULD Cargo"),
        ),
        body: Center(
            child: Container(
                margin: const EdgeInsets.all(30.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButtonFormField<Flight>(
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_drop_down_circle_rounded),
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal)),
                          labelText: 'Flight No',
                        ),
                        onChanged: (Flight? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            flight = value!;
                          });
                        },
                        items:
                        list.map<DropdownMenuItem<Flight>>((Flight value) {
                          return DropdownMenuItem<Flight>(
                            value: value,
                            child: Text(value.flightName),
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
                        onShowPicker:
                            (context, currentValue) {
                          return showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ??
                                  DateTime.now(),
                              lastDate: DateTime(2100));
                        },
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(color: Colors.black),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          border: UnderlineInputBorder(),
                          labelText:'Date',
                          prefixIcon: Icon(Icons.date_range,color: Colors.black,)
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal)),
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
                            minimumSize: const Size.fromHeight(50), // NEW
                          ),
                          onPressed: () {
                            var booking = Booking(uldNumberController.text,1,null,null,null,null);
                            context.router.push(ScanULDCargoRoute(booking: booking));
                          },
                          child: const Text(
                            'Submit',
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ))
                    ]))));
  }
}
