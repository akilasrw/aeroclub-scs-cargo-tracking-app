import 'package:Cargo_Tracker/router/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../domain/data/flight.dart';
import '../../domain/data/load_uld.dart';
import '../../domain/data/sector.dart';
import '../../domain/data/uld_flight_schedule.dart';
import '../../utils/app_utils.dart';
import '../../utils/constants.dart';
import '../common/main_button.dart';
import '../common/main_text_field.dart';
import '../common/navbar.dart';
import '../load_to_uld/uld_load_provider.dart';

@RoutePage()
class ULDCargoLoadingPage extends StatefulWidget {
  final bool isCargoLoading;

  const ULDCargoLoadingPage({Key? key, required this.isCargoLoading})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ULDCargoLoadingPageState();
}

class _ULDCargoLoadingPageState extends State<ULDCargoLoadingPage> {
 // final TextEditingController uldNumberController = TextEditingController();
  Flight? flight = null;
  final TextEditingController dateController = TextEditingController();
  final TextEditingController awbController = TextEditingController();
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
                        ULDLoadProvider()..initProvider(widget.isCargoLoading),
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
                                  title: widget.isCargoLoading
                                      ? "Pack ULD"
                                      : "Unpack ULD"),
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
                                            if(!widget.isCargoLoading){
                                              if(flight != null){
                                                  var uldFlightSchedule = ULDFlightSchedule(
                                                      flightNumber : flight!.flightNumber,
                                                      scheduledDepartureDateTime : dateController.text
                                                  );
                                                  data.getULDs(uldFlightSchedule);
                                              }
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
                                                firstDate: DateTime.now(),
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
                                        if (awbController.text.isEmpty) {
                                          AppUtils.showAlert(
                                              context,
                                              'Error',
                                              "Please add awb number",
                                              false, () {
                                            Navigator.of(context).pop();
                                          });
                                          return;
                                        }
                                        if (awbController.text.length != 11) {
                                          AppUtils.showAlert(
                                              context,
                                              'Error',
                                              "AWB number should contain 11 numbers.",
                                              false, () {
                                            Navigator.of(context).pop();
                                          });
                                          return;
                                        }
                                        validateAWBWithFlight(data);
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

  void validateAWBWithFlight(ULDLoadProvider provider) async{

    String awbNo = awbController.text;
    Sector? sector= await provider.getAirportsByAWB(int.parse(awbNo));
    if(sector != null && checkIsValidSector(sector)){
      bool? isScheduleMatch = await provider.checkFlightScheduleAvailability(dateController.text,flight!.flightNumber!);
      if(isScheduleMatch!){
        bool? isUldMatched = await provider.checkULDAvailability(flight!.flightNumber!,
            dateController.text,selectedUld!);
        if(!isUldMatched!){
          var loadULD = LoadULD(
              flightID: flight?.flightId,
              scheduledDepartureDateTime:
              dateController.text,
              uldSerialNumber: selectedUld,
              uld: selectedUld,
              awbNumber: awbController.text,
              packageIDs: null);
          context.router.push(ScanULDCargoRoute(
              loadULD: loadULD,
              isCargoLoading:
              widget.isCargoLoading));
        }
        else{
          AppUtils.showAlert(
              context,
              'Error',
              "This ULD is already assigned to another flight",
              false, () {
            Navigator.of(context).pop();
          });
        }
      }
      else{
        AppUtils.showAlert(
            context,
            'Error',
            "Given flight date, flight number combination don't have a filght schedule",
            false, () {
          Navigator.of(context).pop();
        });
      }
    }
    else{
      AppUtils.showAlert(
          context,
          'Error',
          "This AWB doesn't match with the flight",
          false, () {
        Navigator.of(context).pop();
      });
    }

  }

  bool checkIsValidSector(Sector awbSector){
    bool isValidSector = false;
    List<Sector> sectors = flight!.sectors!;
    for(Sector sector in sectors){
      if(awbSector.destinationCode == sector.destinationCode && awbSector.originCode == sector.originCode){
        isValidSector = true;
      }
    }
    if(!isValidSector && awbSector.destinationCode == flight!.destinationCode
        && awbSector.originCode == flight!.originCode){
      isValidSector = true;
    }
    return isValidSector;
  }
}
