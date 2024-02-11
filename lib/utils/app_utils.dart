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

  static void showAlert(BuildContext context , String title, String msg,bool isSuccess, Function() onClick){
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
                  isSuccess ?Icons.done_outline : Icons.warning,
                  color: isSuccess ? Colors.lightGreen :Colors.deepOrangeAccent,
                  size: 35.0,
                ),
                SizedBox(
                  width: 15,
                ),

                Text(
                  title,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white),

                ),
              ],
            ),
            content: Text(msg,style: TextStyle(color: Colors.white70),),
            actions: [
              TextButton(
                onPressed: onClick,
                child: const Text('OK',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.orange),

                ),
              ),
            ],
          );
        }
    );
  }

  static void showConfirmation(BuildContext context, String msg , Function() okFunction
      , Function() cancelFunction){
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
                  Icons.warning_amber,
                  color :Colors.deepOrangeAccent,
                  size: 35.0,
                ),
                SizedBox(
                  width: 15,
                ),

                Text(
                  'Warning',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white),

                ),
              ],
            ),
            content: Text(msg,style: TextStyle(color: Colors.white70),),
            actions: [
              TextButton(
                onPressed: okFunction,
                child: const Text('YES',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.green),
                ),
              ),
              TextButton(
                onPressed: cancelFunction,
                child: const Text('NO',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.green),
                ),
              )
            ],
          );});
  }

  static void showMsg(msg,BuildContext context) async {
    // flutter defined function
    await showDialog(
      context: context,
      builder: (BuildContext localContext) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: Colors.grey[800],
          content: new Text(
            msg,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              decoration: TextDecoration.none,
              fontFamily: 'Lato',
              fontWeight: FontWeight.normal,
            ),
          ),
          //content: new Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              child: new Text("Close"),
              onPressed: () async {
                print("poping");
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: new Text("cancel"),
              onPressed: () async {
                print("poping");
              },
            ),
          ],
        );
      },
    ).then((value) {
      print("poping from screen");
      Navigator.of(context).pop();
    });
  }
}
