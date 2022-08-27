import 'package:ferdinand_coffee/components/common.dart';
import 'package:flutter/material.dart';

class InputTextFormField extends StatelessWidget {
  const InputTextFormField({
    required this.labeltext,
    required this.preiconimage,
    required this.suficonimage,
    this.controller,
    Key? key,
  }) : super(key: key);

  final String labeltext;
  final String preiconimage;
  final String suficonimage;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: TextFormField(
        controller: controller,
        style: textFieldTextStyle(),
        decoration: InputDecoration(
          border: textFieldBorder(),
          enabledBorder: textFieldEnabledBorder(),
          isDense: true,
          focusedBorder: textFieldFocusedBorder(),
          prefix: Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 10),
            child: Image.asset(preiconimage),
          ),
          suffix: Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 8),
            child: Image.asset(suficonimage),
          ),
          labelText: labeltext,
          labelStyle: textFieldHintStyle(),
        ),
      ),
    );
  }
}
