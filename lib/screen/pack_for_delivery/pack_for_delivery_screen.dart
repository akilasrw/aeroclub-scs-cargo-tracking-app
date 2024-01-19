import 'dart:convert';

import 'package:Cargo_Tracker/router/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../domain/data/airport.dart';
import '../../domain/data/cargo_agent.dart';

@RoutePage()
class PackForDeliveryPage extends StatefulWidget {
  final bool isPackForDelivery;
  const PackForDeliveryPage({Key? key, required this.isPackForDelivery}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PickUpCargoMainDetailsState();
}

class _PickUpCargoMainDetailsState extends State<PackForDeliveryPage> {
  final TextEditingController truckController = TextEditingController();
  List<Airport> list = List.empty();
  List<CargoAgent> cargoAgents = List.empty();
  CargoAgent? cargoAgent = null;

  @override
  void initState() {
    super.initState();
    getCargoAgents();
  }

  Future<List<CargoAgent>?> getCargoAgents() async {
    try {
      var url = Uri.parse(
          "https://aeroclub-skytechcargo-app-dev-002.azurewebsites.net/api/v1/CargoAgent/GetList");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        setState(() {
          cargoAgents = parsed
              .map<CargoAgent>((json) => CargoAgent.fromMap(json))
              .toList();
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
          title: Text(widget.isPackForDelivery ? "Pack for Delivery" : "Handover to Customer"),
        ),
        body: Center(
            child: SingleChildScrollView(
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
                            icon: const Icon(
                                Icons.arrow_drop_down_circle_rounded),
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
                            items: cargoAgents
                                .map<DropdownMenuItem<CargoAgent>>(
                                    (CargoAgent value) {
                                  return DropdownMenuItem<CargoAgent>(
                                    value: value,
                                    child: Text(value.agentName),
                                  );
                                }).toList(),
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
                                context.router.push(ScanPackForDeliveryRoute());
                              },
                              child: const Text(
                                'Submit',
                                style: TextStyle(
                                    fontSize: 24, color: Colors.black),
                              ))
                        ])))));
  }
}
