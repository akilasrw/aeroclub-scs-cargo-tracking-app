import 'package:Cargo_Tracker/domain/data/booking.dart';
import 'package:Cargo_Tracker/domain/data/cargo_booking_item.dart';
import 'package:Cargo_Tracker/domain/data/load_uld_to_flight_request.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/data/uld_flight_schedule.dart';
import '../../router/router.gr.dart';
import '../../utils/app_utils.dart';
import 'flight_loading_provider.dart';

@RoutePage()
class LoadULDToFlightPage extends StatefulWidget {

  ULDFlightSchedule uldFlightSchedule;
  bool isFlightLoading;

  LoadULDToFlightPage(
      {Key? key, required this.uldFlightSchedule, required this.isFlightLoading})
      : super(key: key);

  @override
  State<LoadULDToFlightPage> createState() => _ScanCargoState();
}

class _ScanCargoState extends State<LoadULDToFlightPage> {
  int scanCount = 0;
  final TextEditingController uldNumberController = TextEditingController();
  List<String> uldNumbersList = [];
  List<String> uldIDsList = [];
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Add ULDs to Flight"),
        ),
        body: SafeArea(child: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                      child: Center(
                          child: Container(
                              margin: const EdgeInsets.all(30.0),
                              child: ChangeNotifierProvider(
                                  create: (BuildContext context) =>
                                      FlightLoadingProvider()..getULDs(widget.uldFlightSchedule),
                                  builder: (context, child) {
                                    return Consumer<FlightLoadingProvider>(
                                        builder: (da, data, child) {
                                      return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("Added Count : $scanCount",
                                                style: TextStyle(
                                                    color: Colors.grey[800],
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 30)),
                                            SizedBox(
                                              height: 40,
                                            ),
                                            Container(
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Expanded(
                                                      flex: 8,
                                                      child: TextField(
                                                          controller:
                                                              uldNumberController,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                          decoration:
                                                              const InputDecoration(
                                                            border: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .teal)),
                                                            labelText: 'ULD No',
                                                          ))),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Material(
                                                      type: MaterialType
                                                          .transparency,
                                                      child: Ink(
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .indigoAccent,
                                                              width: 3.0),
                                                          color: Colors
                                                              .indigo[900],
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: InkWell(
                                                          //This keeps the splash effect within the circle
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      1000.0),
                                                          //Something large to ensure a circle
                                                          onTap: () async {
                                                            if (uldNumberController
                                                                    .text !=
                                                                null) {
                                                              setState(() {
                                                                scanCount++;
                                                                uldNumbersList.add(
                                                                    uldNumberController
                                                                        .text);
                                                                uldIDsList.add(data.uldSerialNumberIdMap[uldNumberController
                                                                    .text]);
                                                              });
                                                              uldNumberController
                                                                  .clear();
                                                            }
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    15.0),
                                                            child: Icon(
                                                              Icons
                                                                  .add_circle_outline,
                                                              size: 25.0,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 0,
                                                child: uldNumbersList.length > 0
                                                    ? ListView.builder(
                                                        controller:
                                                            _scrollController,
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemCount:
                                                            uldNumbersList
                                                                .length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return Text(
                                                              uldNumbersList[
                                                                  index],
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      20));
                                                        })
                                                    : SizedBox(),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 40,
                                            ),
                                            data.isLoading ?
                                            const Center(
                                              child: CircularProgressIndicator(),
                                            ) :
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.blue,
                                                  minimumSize:
                                                      const Size.fromHeight(
                                                          50), // NEW
                                                ),
                                                onPressed: () {
                                                  onSubmit(data);
                                                },
                                                child: const Text(
                                                  'Done',
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      color: Colors.black),
                                                ))
                                          ]);
                                    });
                                  }))))));
        })));
  }

  Future<void> onSubmit(FlightLoadingProvider data) async {
    LoadULDtoFlightRequest? loadUld = LoadULDtoFlightRequest(isArrived: !widget.isFlightLoading,
        ulds: uldIDsList);
    var isPacked = await data.loadUldToFlight(loadUld);
    if(isPacked){
      showAlert("Success", "Cargo ${widget.isFlightLoading ? "loaded" : "unloaded"} Successfully",redirectToHome);
    }
    else{
      showAlert("Error", "Something went wrong", onFailMethod);
    }
  }

  void showAlert(String title, String msg , Function() function){
    AppUtils.showAlert(context, title, msg,function);
  }
  void redirectToHome(){
    context.router.push(const HomeRoute());
  }

  void onFailMethod(){
    Navigator.of(context).pop();
  }
}
