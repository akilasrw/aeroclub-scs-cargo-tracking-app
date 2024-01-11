import 'dart:convert';

import 'package:Cargo_Tracker/domain/data/booking.dart';
import 'package:Cargo_Tracker/router/router.gr.dart';
import 'package:Cargo_Tracker/screen/pickup_cargo/scan_cargo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:http/http.dart' as http;

import '../../domain/data/airport.dart';
import '../../domain/data/cargo_agent.dart';


@RoutePage()
class PickUpCargoMainDetailsPage extends StatefulWidget {
  const PickUpCargoMainDetailsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PickUpCargoMainDetailsState();
}

class _PickUpCargoMainDetailsState extends State<PickUpCargoMainDetailsPage> {
  String result = '';
  final TextEditingController awbController = TextEditingController();
  final TextEditingController truckController = TextEditingController();
  List<Airport> list = List.empty();
  List<CargoAgent> cargoAgents = List.empty();
  Airport? originAirport = null;
  Airport? desitnationAirport = null;
  CargoAgent? cargoAgent = null;
  @override
  void initState() {
    super.initState();
    getAirports();
    getCargoAgents();
  }
  List<Airport> parseProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Airport>((json) =>Airport.fromMap(json)).toList();
  }

  Future<List<Airport>?> getAirports() async {
    try {
      var url = Uri.parse("https://aeroclub-skytechcargo-app-dev-002.azurewebsites.net/api/v1/airport/getSelectList");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          list = parseProducts(response.body);
        });
      }
    } catch (e) {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  Future<List<CargoAgent>?> getCargoAgents() async {
    try {
      var url = Uri.parse("https://aeroclub-skytechcargo-app-dev-002.azurewebsites.net/api/v1/CargoAgent/GetList");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        setState(() {
          cargoAgents =  parsed.map<CargoAgent>((json) =>CargoAgent.fromMap(json)).toList();
        });
        return cargoAgents;
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
          title: Text("Pick Up Cargo"),
        ),
        body: Center(
            child: Container(
                margin: const EdgeInsets.all(30.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal)),
                          labelText: 'Truck Number',
                        ),
                        controller: truckController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField<CargoAgent>(
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_drop_down_circle_rounded),
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal)),
                          labelText: 'Agent',
                        ),
                        onChanged: (CargoAgent? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            cargoAgent = value!;
                          });
                        },
                        items:
                        cargoAgents.map<DropdownMenuItem<CargoAgent>>((CargoAgent value) {
                          return DropdownMenuItem<CargoAgent>(
                            value: value,
                            child: Text(value.agentName),
                          );
                        }).toList(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField<Airport>(
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_drop_down_circle_rounded),
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal)),
                          labelText: 'Origin',
                        ),
                        onChanged: (Airport? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            originAirport = value!;
                          });
                        },
                        items:
                        list.map<DropdownMenuItem<Airport>>((Airport value) {
                          return DropdownMenuItem<Airport>(
                            value: value,
                            child: Text(value.value),
                          );
                        }).toList(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                       DropdownButtonFormField<Airport>(
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_drop_down_circle_rounded),
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal)),
                          labelText: 'Destination',
                        ),
                        onChanged: (Airport? value) {
                          setState(() {
                            desitnationAirport = value!;
                          });
                        },
                        items:
                            list.map<DropdownMenuItem<Airport>>((Airport value) {
                          return DropdownMenuItem<Airport>(
                            value: value,
                            child: Text(value.value),
                          );
                        }).toList(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                                flex: 8,
                                child: TextField(
                                    controller: awbController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.teal)),
                                      labelText: 'AWB No',
                                    ))),
                            SizedBox(
                              width: 10,
                            ),
                            Material(
                                type: MaterialType.transparency,
                                child: Ink(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.indigoAccent, width: 3.0),
                                    color: Colors.indigo[900],
                                    shape: BoxShape.circle,
                                  ),
                                  child: InkWell(
                                    //This keeps the splash effect within the circle
                                    borderRadius: BorderRadius.circular(1000.0),
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
                                          result = res;
                                          awbController.text = res;
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
                        height: 10,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            minimumSize: const Size.fromHeight(50), // NEW
                          ),
                          onPressed: () {
                            var booking = Booking(awbController.text,1,originAirport?.id,desitnationAirport?.id,truckController.text,null);
                            context.router.push(ScanCargoRoute(booking: booking));
                          },
                          child: const Text(
                            'Submit',
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ))
                    ]))));
  }
}
