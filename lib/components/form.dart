import 'package:ferdinand_coffee/components/common.dart';

import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  CustomFormField(
      {Key? key,
      this.onChanged,
      this.labelText,
      this.obscureText = false,
      this.inputType,
      this.maxLines = 1,
      this.controller,
      this.validator})
      : super(key: key);
  Function(String)? onChanged;
  String? Function(String?)? validator;
  bool obscureText = false;
  String? labelText;
  TextEditingController? controller;
  TextInputType? inputType;
  int? maxLines;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
      maxLines: maxLines,
      style: textFieldTextStyle(),
      decoration: InputDecoration(
        isDense: true,
        border: textFieldBorder(),
        enabledBorder: textFieldEnabledBorder(),
        focusedBorder: textFieldFocusedBorder(),
        labelStyle: textFieldHintStyle(),
        labelText: labelText,
      ),
    );
  }
}

// Liri House Blend / Kaffeebohnen
class CustomButton extends StatelessWidget {
  CustomButton({Key? key, this.onTap, this.buttonText}) : super(key: key);
  Function()? onTap;
  String? buttonText;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
              colors: [
                Color(0xff577860),
                Color(0xff577860),
              ],
              begin: Alignment.topCenter,
              stops: [0.09, 1],
              end: Alignment.bottomCenter),
        ),
        child: Center(
          child: Text(
            '$buttonText',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
