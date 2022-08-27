import 'package:flutter/material.dart';

class MainSubmitButton extends StatelessWidget {
  const MainSubmitButton({
    required this.function,
    required this.buttonlabel,
    this.buttonwidth,
    this.buttoncolor,
    this.buttonheight,
    this.buttontextcolor,
    Key? key,
  }) : super(key: key);
  final Function() function;
  final String buttonlabel;
  final Color? buttoncolor;
  final double? buttonwidth;
  final double? buttonheight;
  final Color? buttontextcolor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1),
        child: Container(
          height: buttonheight ?? 50,
          width: buttonwidth,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: buttoncolor ?? const Color(0xff577860),
              borderRadius: BorderRadius.circular(8)),
          child: Text(
            buttonlabel,
            style: TextStyle(
                color: buttontextcolor ?? Colors.white,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
