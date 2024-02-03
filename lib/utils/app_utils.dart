import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppUtils {
  static bool isValidateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return (!regex.hasMatch(value)) ? false : true;
  }

  static String toCurrencyStringFormate(double value) {
    return NumberFormat.simpleCurrency(name: 'USD', decimalDigits: 0)
        .format(value);
  }

  static void showAlert(BuildContext context , String title, String msg, Function() onClick){
    showDialog(
        context: context,
        builder : (BuildContext context){
          return AlertDialog(
            title: Text(title),
            content: Text(msg),
            actions: [
              TextButton(
                onPressed: onClick,
                child: Text('OK'),
              ),
            ],
          );
        }
    );
  }
}
