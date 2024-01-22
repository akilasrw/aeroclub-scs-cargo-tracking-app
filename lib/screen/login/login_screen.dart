import 'dart:convert';

import 'package:Cargo_Tracker/provider/login_provider/provider.dart';
import 'package:Cargo_Tracker/router/router.gr.dart';
import 'package:Cargo_Tracker/screen/home/home.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double heightSpacingFactor = 20;
  BoxConstraints buttonBoxConstraint =
      const BoxConstraints(minWidth: double.infinity, minHeight: 40);

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  Future<void> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
    ].request();

    statuses.forEach((key, value) {
      print('$key permission : $value');
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      requestPermissions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData _mediaQueryData = MediaQuery.of(context);
    final height = _mediaQueryData.size.height -
        (_mediaQueryData.padding.bottom + _mediaQueryData.padding.top);
    final logoWidth = _mediaQueryData.size.width * 0.5;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: LayoutBuilder(builder:
              (BuildContext context, BoxConstraints viewportConstraints) {
            return ChangeNotifierProvider(
              create: (BuildContext context) => LoginProviderProvider(),
              builder: (context, child) {
                final provider = context.read<LoginProviderProvider>();

                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              child: Stack(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: SvgPicture.asset(
                                          'images/ikigai-cargo.svg',
                                          colorBlendMode: BlendMode.srcIn,
                                          width: logoWidth,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('welcome Back',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  ?.copyWith(
                                                      color: Colors.blue[900],
                                                      fontSize: 35))
                                        ],
                                      ),
                                      Text(
                                        'Login to your existing account',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            ?.copyWith(
                                                color: Colors.teal,
                                                fontSize: 20),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextField(
                                        controller: userNameController,
                                        focusNode: emailFocus,
                                        style: TextStyle(color: Colors.black45),
                                        obscureText: false,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.teal)),
                                          labelText: 'Username',
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextField(
                                        controller: passwordController,
                                        focusNode: passwordFocus,
                                        style: TextStyle(color: Colors.black45),
                                        obscureText: true,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.teal)),
                                          labelText: 'Password',
                                        )),
                                    SizedBox(
                                      height: heightSpacingFactor,
                                    ),
                                    Consumer<LoginProviderProvider>(
                                        builder: (context, data, child) {
                                      if (data.isLoading) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      return ElevatedButton(
                                        key: UniqueKey(),
                                        child: const Text(
                                          'Login',
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.black),
                                        ),
                                        onPressed: () async {
                                          if (_formKey.currentState != null &&
                                              _formKey.currentState!
                                                  .validate()) {
                                            if (await provider.login(
                                                userNameController.text.trim(),
                                                passwordController.text
                                                    .trim())) {
                                              navigateToNextPage();
                                            }
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          minimumSize:
                                              const Size.fromHeight(50), // NEW
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }

  void navigateToNextPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("userName", "akila");
    await prefs.setString("userType", "warehouse");
    navigate();
  }

  void navigate() {
    context.router.push(const HomeRoute());
  }

  void setLoading(bool isLoading) {
    setState(() {
      this.isLoading = isLoading;
    });
  }
}
