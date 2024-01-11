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
}
