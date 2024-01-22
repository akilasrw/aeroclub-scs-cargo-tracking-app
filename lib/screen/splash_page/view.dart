import 'package:Cargo_Tracker/router/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

@RoutePage()
class SplashPagePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => SplashPageProvider(),
      builder: (context, child) {
        final provider = context.read<SplashPageProvider>();
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          Future.delayed(const Duration(seconds: 2), () {
            provider.isUserAuthenticate().then((isAuthenticate) {
              if (isAuthenticate) {
                context.router.push(const HomeRoute());
              } else {
                context.router.push(const LoginRoute());
              }
            });
          });
        });
       return Scaffold(
          body: SafeArea(
              child: Container(
                color: Colors.white,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )),
        );
      },
    );
  }

}
