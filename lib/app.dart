import 'package:Cargo_Tracker/provider/app_provider.dart';
import 'package:Cargo_Tracker/router/router.dart';
import 'package:Cargo_Tracker/screen/app/theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:provider/provider.dart';

const channelId = 'aero';
const channelName = 'aero package';
const channelDescription = 'natural womens health Daily routine';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _appRouter = GetIt.I<AppRouter>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppProvider(),
        ),

      ],
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            routerDelegate: _appRouter.delegate(),
            routeInformationParser: _appRouter.defaultRouteParser(),
            title: 'Price Tracker',
           // theme: AppTheme().buildTheme(),
          );
        },
      ),
    );
  }
}
