import 'package:ferdinand_coffee/core/constants.dart';
import 'package:flutter/material.dart';

TextStyle textFieldHintStyle() {
  return const TextStyle(color: Constants.greyColor, fontSize: 12);
}

TextStyle textFieldTextStyle() => const TextStyle(color: Constants.greyColor);

OutlineInputBorder textFieldFocusedBorder() {
  return const OutlineInputBorder(
    borderSide: BorderSide(
        width: 1, color: Constants.orangeColor, style: BorderStyle.solid),
  );
}

OutlineInputBorder textFieldBorder() {
  return const OutlineInputBorder(
    borderSide: BorderSide(
        width: 1, color: Constants.greyColor, style: BorderStyle.solid),
  );
}

OutlineInputBorder textFieldEnabledBorder() {
  return const OutlineInputBorder(
    borderSide: BorderSide(
        width: 1, color: Constants.greyColor, style: BorderStyle.solid),
  );
}
