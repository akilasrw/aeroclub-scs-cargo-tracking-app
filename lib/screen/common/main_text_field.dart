import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainTextField extends StatefulWidget {
  final String labelText;
  final TextEditingController? controller;
  final bool isEmpty;
  final TextInputType type;
  final TextInputAction action;
  final bool obscureText;
  final bool isLargeText;
  final int minLines;
  final int? maxLines;
  final bool isRequired;
  final bool enable;
  final TextAlign align;
  final ValueSetter<bool> onValueChanged;
  final ValueChanged<String>? onChangedText;
  final Widget? suffix;

  const MainTextField(
      {Key? key,
      required this.labelText,
      this.controller,
      this.isEmpty = false,
      this.type = TextInputType.text,
      this.action = TextInputAction.done,
      this.obscureText = false,
      this.isLargeText = false,
      this.minLines = 1,
      this.maxLines,
      this.isRequired = true,
      this.enable = true,
      this.align = TextAlign.start,
      required this.onValueChanged,
      this.onChangedText,
      this.suffix = const SizedBox()})
      : super(key: key);

  @override
  State<MainTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField> {
  @override
  Widget build(BuildContext context) {
    Color setColor() {
      if (widget.isEmpty) {
        return Colors.red;
      } else {
        return Colors.white;
      }
    }

    return TextField(
      controller: widget.controller,
      keyboardType: widget.type,
      textInputAction: widget.action,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      enabled: widget.enable,
      textAlign: widget.align,
      style: const TextStyle(
        color: Color(0xFF001C31),
      ),
      decoration: InputDecoration(
        fillColor: Colors.white,
        alignLabelWithHint: true,
        filled: true,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: setColor()),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: setColor()),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: setColor()),
        ),
        hintText: widget.labelText,
        hintStyle: TextStyle(
            color: const Color(0xFF001C31).withOpacity(0.6), fontSize: 14),
          suffix : widget.suffix
      ),
      obscureText: widget.obscureText,
      onChanged: (String value) {
        if (widget.isRequired) {
          final isEmpty = value.trim().isEmpty;
          widget.onValueChanged(isEmpty);
        }

        final ValueChanged<String>? onSubmitted = widget.onChangedText;
        if (onSubmitted == null) {
          return;
        }

        onSubmitted(value);
      },
      onSubmitted: (String value) {
        if (widget.isRequired) {
          final isEmpty = value.trim().isEmpty;
          widget.onValueChanged(isEmpty);
        }
      },
      inputFormatters: widget.type ==
              const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              )
          ? [
              FilteringTextInputFormatter.allow(
                RegExp(r'^(\d+)?\.?\d{0,2}'),
              ),
            ]
          : [],
    );
  }
}
