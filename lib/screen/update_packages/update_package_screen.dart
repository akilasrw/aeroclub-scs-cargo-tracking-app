import 'package:Cargo_Tracker/router/router.gr.dart';
import 'package:Cargo_Tracker/screen/pickup_cargo/provider.dart';
import 'package:Cargo_Tracker/screen/update_packages/package_update_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import '../../domain/data/booking_status.dart';
import 'package:provider/provider.dart';
import '../../utils/app_utils.dart';
import '../common/main_button.dart';
import '../common/main_text_field.dart';
import '../common/navbar.dart';
import 'package.dart';

@RoutePage()
class UpdatePackagePage extends StatefulWidget {
  const UpdatePackagePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UpdatePackagePageState();
}

class _UpdatePackagePageState extends State<UpdatePackagePage> {
  String result = '';
  final TextEditingController awbController = TextEditingController();
  final TextEditingController packageIdController = TextEditingController();
  Package? package = null;
  final TextEditingController weightController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController lengthController = TextEditingController();
  bool isSearchDone = false;
  bool isFieldUpdated = false;


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
                    PackageUpdateProvider()..initProvider(),
                    builder: (context, child) {
                      return Consumer<PackageUpdateProvider>(
                          builder: (da, data, child) {
                        return Stack(
                          children: [
                            Positioned(
                              top: 0,
                              right: 0,
                              left: 0,
                              child: Navbar(title: "Update Package Details"),
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
                                                    result = res;
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
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: MainTextField(
                                                labelText: 'Package No',
                                                onValueChanged: (bool value) {},
                                                controller: packageIdController,
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
                                                    result = res;
                                                    packageIdController.text =
                                                        res;
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
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 10),
                                          child: MainButton(
                                            title: 'Search',
                                            onTapped: () {
                                              setState(() {
                                                isSearchDone = true;
                                              });
                                              if (awbController.text.isEmpty) {
                                                AppUtils.showAlert(
                                                    context,
                                                    'Error',
                                                    "Please add AWB number",
                                                    false, () {
                                                  Navigator.of(context).pop();
                                                });
                                                return;
                                              }
                                              if (packageIdController
                                                  .text.isEmpty) {
                                                AppUtils.showAlert(
                                                    context,
                                                    'Error',
                                                    "Please add Package number",
                                                    false, () {
                                                  Navigator.of(context).pop();
                                                });
                                                return;
                                              }
                                              updateTextFields(data, awbController.text,packageIdController.text);
                                            },
                                          ),
                                        ),
                                        isSearchDone ?
                                        Column(
                                            children: [
                                          Divider(
                                              height: 20,
                                              thickness: 1,
                                              indent: 20,
                                              endIndent: 0,
                                              color: Colors.grey),
                                          SizedBox(height: 10),
                                          Row(
                                              children: [
                                            Text("Weight : ",
                                              style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14
                                            )
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: MainTextField(
                                                labelText: 'Weight',
                                                onValueChanged: (bool value) {
                                                  isFieldUpdated = true;
                                                  try {
                                                    if(weightController.text.isNotEmpty){
                                                      double weight = double.parse(weightController.text);
                                                      data.package?.weight = weight;
                                                    }
                                                  } catch (e) {
                                                    AppUtils.showAlert(
                                                        context,
                                                        'Error',
                                                        "Invalid weight specified",
                                                        false, () {
                                                      Navigator.of(context).pop();
                                                    });
                                                  }
                                                },
                                                controller: weightController,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text("Kg",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14
                                                )),

                                          ]),
                                          SizedBox(height: 10),
                                          Row(
                                              children: [
                                                Text("Height : ",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14
                                                    )
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: MainTextField(
                                                    labelText: 'Height',
                                                    onValueChanged: (bool value) {
                                                      isFieldUpdated = true;
                                                      try {
                                                        if(heightController.text.isNotEmpty){
                                                          double height = double.parse(heightController.text);
                                                          data.package?.height = height;
                                                        }
                                                      } catch (e) {
                                                        AppUtils.showAlert(
                                                            context,
                                                            'Error',
                                                            "Invalid height specified",
                                                            false, () {
                                                          Navigator.of(context).pop();
                                                        });
                                                      }
                                                    },
                                                    controller: heightController,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Text("cm",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14
                                                    )),

                                              ]),
                                          SizedBox(height: 10),
                                          Row(
                                              children: [
                                                Text("Width : ",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14
                                                    )
                                                ),
                                                const SizedBox(
                                                  width: 12,
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: MainTextField(
                                                    labelText: 'Width',
                                                    onValueChanged: (bool value) {
                                                      isFieldUpdated = true;
                                                      try {
                                                        if(widthController.text.isNotEmpty){
                                                          double width = double.parse(widthController.text);
                                                          data.package?.width = width;
                                                        }
                                                      } catch (e) {
                                                        AppUtils.showAlert(
                                                            context,
                                                            'Error',
                                                            "Invalid width specified",
                                                            false, () {
                                                          Navigator.of(context).pop();
                                                        });
                                                      }
                                                    },
                                                    controller: widthController,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Text("cm",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14
                                                    )),

                                              ]),
                                          SizedBox(height: 10),
                                          Row(
                                              children: [
                                                Text("Length : ",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14
                                                    )
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: MainTextField(
                                                    labelText: 'Length',
                                                    onValueChanged: (bool value) {
                                                      isFieldUpdated = true;
                                                      try {
                                                        if(lengthController.text.isNotEmpty){
                                                          double length = double.parse(lengthController.text);
                                                          data.package?.length = length;
                                                        }
                                                      } catch (e) {
                                                        AppUtils.showAlert(
                                                            context,
                                                            'Error',
                                                            "Invalid length specified",
                                                            false, () {
                                                          Navigator.of(context).pop();
                                                        });
                                                      }
                                                    },
                                                    controller: lengthController,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Text("cm",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14
                                                    )),

                                              ]),
                                          SizedBox(height: 10),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 10),
                                            child: MainButton(
                                              title: 'Update',
                                              onTapped: () {
                                                if (weightController.text.isEmpty) {
                                                  AppUtils.showAlert(
                                                      context,
                                                      'Error',
                                                      "Please update the weight",
                                                      false, () {
                                                    Navigator.of(context).pop();
                                                  });
                                                  return;
                                                }
                                                if (widthController
                                                    .text.isEmpty || lengthController.text.isEmpty || heightController.text.isEmpty) {
                                                  AppUtils.showAlert(
                                                      context,
                                                      'Error',
                                                      "Please update the dimensions",
                                                      false, () {
                                                    Navigator.of(context).pop();
                                                  });
                                                  return;
                                                }
                                                onSubmit(data);
                                              },
                                            ),
                                          )
                                        ]) : SizedBox(height: 100,),
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

  Future<void> onSubmit(PackageUpdateProvider data) async {
    if(isFieldUpdated){
      bool isPacked = await data.updatePackage(data.package!);

      if(isPacked){
        showAlert("Success", "Package updated successfully",true,redirectToHome);
      }
      else{
        showAlert("Error", "Something went wrong",false, onFailMethod);
      }
    }
    else{
      showAlert("Warning", "No field has updated",false, onFailMethod);
    }
  }

  void onFailMethod() {
    Navigator.of(context).pop();
  }

  void showAlert(String title, String msg,bool isSuccess, Function() function) {
    AppUtils.showAlert(context, title, msg,isSuccess, function);
  }

  void redirectToHome() {
    context.router.push(const HomeRoute());
  }

  void updateTextFields(PackageUpdateProvider data,String awbNo, String packageRef) async{
    Package package = await data.getPackageItem(awbController.text,packageIdController.text);
    weightController.text = package.weight.toString();
    widthController.text = package.width.toString();
    lengthController.text = package.length.toString();
    heightController.text = package.height.toString();
  }
}
