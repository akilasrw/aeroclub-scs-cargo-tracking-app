import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/data/load_uld_to_flight_request.dart';
import '../../domain/data/uld_flight_schedule.dart';
import '../../router/router.gr.dart';
import '../../utils/app_utils.dart';
import '../common/main_button.dart';
import '../common/navbar.dart';
import 'flight_loading_provider.dart';

@RoutePage()
class ULDPackListPage extends StatefulWidget {
  ULDFlightSchedule uldFlightSchedule;
  bool isFlightLoading;

  ULDPackListPage(
      {Key? key,
      required this.uldFlightSchedule,
      required this.isFlightLoading})
      : super(key: key);

  @override
  State<ULDPackListPage> createState() => _ULDPackListPageState();
}

class _ULDPackListPageState extends State<ULDPackListPage> {
  var uldAddStatus = {};
  List<String> uldIDsList = [];
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
                    FlightLoadingProvider()..getULDs(widget.uldFlightSchedule),
                builder: (context, child) {
                  return Consumer<FlightLoadingProvider>(
                      builder: (da, data, child) {
                    return Stack(
                      children: [
                         Positioned(
                          top: 0,
                          right: 0,
                          left: 0,
                          child: Navbar(title: "Verify Flight ULD"),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 70,
                          bottom: 10,
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                children: [
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          data.uldSerialNumberIdMap.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding:
                                          const EdgeInsets.only(bottom: 100),
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF132F47),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                data.uldSerialNumberList[index],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ),
                                              CupertinoSwitch(
                                                  activeColor:
                                                      const Color(0xFF0D6AD4),
                                                  value: uldAddStatus[
                                                              data.uldSerialNumberList[
                                                                  index]] !=
                                                          null &&
                                                      uldAddStatus[
                                                          data.uldSerialNumberList[
                                                              index]],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      uldAddStatus[
                                                          data.uldSerialNumberList[
                                                              index]] = value;
                                                      if(value){
                                                        uldIDsList.add(data.uldSerialNumberIdMap[data.uldSerialNumberList[
                                                        index]]);
                                                      }
                                                      else{
                                                        uldIDsList.remove(data.uldSerialNumberIdMap[data.uldSerialNumberList[
                                                        index]]);
                                                      }
                                                    });
                                                  })
                                            ],
                                          ),
                                        );
                                      }),
                                ],
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
                                    horizontal: 15, vertical: 5),
                                child:
                                data.isLoading ?
                                const Center(
                                  child: CircularProgressIndicator(),
                                ) :MainButton(
                                  title: 'SUBMIT',
                                  onTapped: () {
                                    onSubmit(data);
                                  },
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                color: const Color(0xFF223343),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
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
                })),
      ),
    );
  }

  Future<void> onSubmit(FlightLoadingProvider data) async {
    LoadULDtoFlightRequest? loadUld = LoadULDtoFlightRequest(isArrived: !widget.isFlightLoading,
        ulds: uldIDsList);
    var isPacked = await data.loadUldToFlight(loadUld);
    if(isPacked){
      showAlert("Success", "Cargo ${widget.isFlightLoading ? "loaded" : "unloaded"} Successfully",true,redirectToHome);
    }
    else{
      showAlert("Error", "Something went wrong",false, onFailMethod);
    }
  }

  void showAlert(String title, String msg , bool isSuccess, Function() function){
    AppUtils.showAlert(context, title, msg,isSuccess,function);
  }
  void redirectToHome(){
    context.router.push(const HomeRoute());
  }

  void onFailMethod(){
    Navigator.of(context).pop();
  }
}
