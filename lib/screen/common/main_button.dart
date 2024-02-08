
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String title;
  final Color bgColor;
  final double fontSize;
  final Color titleColor;
  final FontWeight fontWeight;
  final VoidCallback onTapped;

  const MainButton(
      {Key? key,
        required this.title,
        this.bgColor = const Color(0xFF0671C3),
        this.fontSize = 15,
        this.titleColor = Colors.white,
        this.fontWeight = FontWeight.normal,
        required this.onTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onTapped();
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.zero,
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          bgColor,
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                fontWeight: fontWeight, fontSize: fontSize, color: titleColor),
          ),
        ),
      ),
    );
  }
}
