import 'package:flutter/material.dart';
import 'package:local_vendor_app/globals.dart';

class ActionButton extends StatefulWidget {
  final String text;
  final Function onPressed;
  final Color? fillColor;
  final bool isFilled;
  const ActionButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.fillColor,
    this.isFilled = false,
  }) : super(key: key);

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  late double width, height;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => widget.onPressed(),
      child: Container(
        height: 0.06 * height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: widget.fillColor ?? accentColor,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
