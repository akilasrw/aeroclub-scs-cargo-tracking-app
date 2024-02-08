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

import '../common/main_button.dart';
import '../common/main_text_field.dart';

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
  bool _isObscure = true;

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

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF001C31),
        body: SafeArea(
          child: LayoutBuilder(builder:
              (BuildContext context, BoxConstraints viewportConstraints) {
            return ChangeNotifierProvider(
              create: (BuildContext context) => LoginProviderProvider(),
              builder: (context, child) {
                final provider = context.read<LoginProviderProvider>();

                return Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Welcome",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        "Login to your Existing Account",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white60,
                        ),
                      ),
                      const Spacer(),
                      // logo assets
                      SvgPicture.asset(
                        'images/ikigai-cargo.svg',
                        colorBlendMode: BlendMode.srcIn,
                        width: logoWidth,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * .1),
                        child:
                        Form(
                            key: _formKey,
                            child:  Column(
                              children: [
                                MainTextField(
                                  controller: userNameController,
                                  labelText: 'Username',
                                  onValueChanged: (bool value) {},
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                MainTextField(
                                  controller: passwordController,
                                  labelText: 'Password',
                                  maxLines: 1,
                                  obscureText: _isObscure,
                                  suffix: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _isObscure = !_isObscure;
                                        });
                                      },
                                      child: _isObscure
                                          ? Icon(
                                        Icons.visibility_off,
                                        color: Colors.grey,
                                      )
                                          : Icon(
                                        Icons.visibility,
                                        color: Colors.black,
                                      )),
                                  onValueChanged: (bool value) {},
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Consumer<LoginProviderProvider>(
                                    builder: (context, data, child) {
                                      if (data.isLoading) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      return MainButton(
                                          title: 'LOGIN',
                                          onTapped: () async {
                                            if (_formKey.currentState != null &&
                                                _formKey.currentState!.validate()) {
                                              if (await provider.login(
                                                  userNameController.text.trim(),
                                                  passwordController.text.trim())) {
                                                navigateToNextPage();
                                              } else {
                                                showAlert(
                                                    "Please insert the correct username and password!");
                                              }
                                            }
                                          });
                                    }),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(),
                                    InkWell(
                                      onTap: () {},
                                      child: const Text(
                                        "Reset Password",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )),
                      ),
                      const Spacer(),
                      const Spacer(),
                      const Spacer(),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "version 1.1.0",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.white60,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }

  void showAlert(String msg) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("LOGIN FAILED!"),
            content: Text(
              msg,
              style: TextStyle(color: Colors.black45),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        });
  }

  void navigateToNextPage() async {
    context.router.push(const HomeRoute());
  }

  void setLoading(bool isLoading) {
    setState(() {
      this.isLoading = isLoading;
    });
  }
}
