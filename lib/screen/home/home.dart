import 'package:Cargo_Tracker/router/router.gr.dart';
import 'package:Cargo_Tracker/screen/home/home_grid.dart';
import 'package:Cargo_Tracker/screen/home/home_provider.dart';
import 'package:flutter_svg/svg.dart';
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
    Color mainColor = const Color(0xFF001C31);
    var _localStorage = LocalStorage();
    final MediaQueryData _mediaQueryData = MediaQuery.of(context);
    final logoWidth = _mediaQueryData.size.width * 0.12;

    return PopScope(
        canPop: false,
      child: Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        // title: Text("Home"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
                Icons.power_settings_new,
                size: 25.0,
                color:
                Colors.white,
            ),
            onPressed: () {
              verifyLogout(context,_localStorage);
            },
          ),
        ],
      ),
      // drawer: HomeDrawer(),
      body: Center(
        child: ChangeNotifierProvider(
          create: (BuildContext context) => HomeProvider()..initProvider(),
          builder: (context, child) {
            return Consumer<HomeProvider>(
              builder: (context, data, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Text('Welcome to Ikigai Cargo',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(
                                color: Colors.white,
                                fontSize: 24)),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: HomeGrid(
                        isAdminUser: data.isAdminUser,
                        isTruckDriver: data.isTruckDriver,
                        isWarehouseUser: data.isWarehouseUser,
                      ),

                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SvgPicture.asset(
                      'images/ikigai-logo-icon.svg',
                      colorBlendMode: BlendMode.srcIn,
                      width: 60,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),

    ));
  }

  void verifyLogout(BuildContext context,LocalStorage _localStorage){
    showDialog(
        context: context,
        builder : (BuildContext context){
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          side: BorderSide(color: Color(0xFF032F50))
      ),
      backgroundColor: const Color(0xFF001C31),
      title: Row(
        children: [
          Icon(
            Icons.settings_power,
            color :Colors.deepOrangeAccent,
            size: 35.0,
          ),
          SizedBox(
            width: 15,
          ),

          Text(
            'Logout',
            style: TextStyle(
                fontSize: 18,
                color: Colors.white),

          ),
        ],
      ),
      content: Text('Are you sure you want to logout?',style: TextStyle(color: Colors.white70),),
      actions: [
        TextButton(
          onPressed: (){
            _localStorage.logOutUser();
            context.router.push(const LoginRoute());
          },
          child: const Text('YES',
            style: TextStyle(
                fontSize: 14,
                color: Colors.green),
          ),
        ),
        TextButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          child: const Text('NO',
            style: TextStyle(
                fontSize: 14,
                color: Colors.green),
          ),
        )
      ],
    );});
  }
}
