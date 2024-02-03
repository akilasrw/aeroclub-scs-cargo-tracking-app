import 'package:Cargo_Tracker/router/router.gr.dart';
import 'package:Cargo_Tracker/screen/home/home_grid.dart';
import 'package:Cargo_Tracker/screen/home/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../data/local/local_storage.dart';
import 'home_drawer.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Home"),
        ),
        drawer: HomeDrawer(),
        body: Center(
          child: ChangeNotifierProvider(
              create: (BuildContext context) => HomeProvider()..initProvider(),
              builder: (context, child) {
                return Consumer<HomeProvider>(builder: (da, data, child) {
                  return HomeGrid(isAdminUser: data.isAdminUser,
                      isTruckDriver: data.isTruckDriver,
                  isWarehouseUser: data.isWarehouseUser,);
                });
              }),
        ));
  }
}
