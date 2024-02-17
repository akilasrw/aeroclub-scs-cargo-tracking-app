import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  final String title;
  final bool isDeleteButtonRequired;
  final VoidCallback? onDeleteButtonClicked;

  Navbar({super.key, required this.title,
    this.isDeleteButtonRequired = false,
    this.onDeleteButtonClicked});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          color: const Color(0xFF0C2237),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              Flexible(fit: FlexFit.tight, child: SizedBox()),
              isDeleteButtonRequired ?
              Align(
                  alignment: Alignment.center,
                 child : InkWell(
                  onTap: onDeleteButtonClicked,
                  child: Container(
                    child: const Center(
                      child: Icon(
                        Icons.delete_forever,
                        size: 22,
                        color: Colors.white,
                      ),
                    ),
                ),
              ))
                  : SizedBox()
            ],
          ),
        ),
        Container(
          height: 2,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0C2237),
                Color(0xFF2F5A85),
                Color(0xFF0C2237),
              ],
            ),
          ),
        )
      ],
    );
  }
}
