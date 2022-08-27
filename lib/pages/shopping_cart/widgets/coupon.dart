import 'package:ferdinand_coffee/components/snackbar.dart';
import 'package:ferdinand_coffee/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../components/fluttertoast.dart';

class Coupon extends StatelessWidget {
  Coupon({Key? key, this.couponController, this.hintText}) : super(key: key);
  Function(String?)? couponController;
  String? hintText;
  String? buttonText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
            color: Constants.orangeColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage("assets/icons/gift.png"),
                    width: 40,
                    height: 40,
                    color: Constants.greenColor,
                  ),
                  SizedBox(
                    width: 150,
                    height: 19,
                    // color: Colors.amber,
                    child: Center(
                      child: TextFormField(
                        onChanged: couponController,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(
                            07,
                            107,
                            107,
                            1,
                          ),
                        ),
                        decoration: InputDecoration(
                            errorBorder: InputBorder.none,
                            contentPadding: const EdgeInsets.only(bottom: 12),
                            border: InputBorder.none,
                            hintText: hintText,
                            hintStyle: const TextStyle(
                              fontSize: 12,
                              color: Constants.orangeColor,
                            )),
                      ),
                    ),
                  ),
                  const Text(
                    "",
                    style: TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(
                          07,
                          107,
                          107,
                          1,
                        ),
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 55,
                // height: 39,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Constants.greenColor,
                    borderRadius: BorderRadius.circular(5)),
                child: InkWell(
                  onTap: () {
                    displayToast(Colors.green, Colors.white,
                        AppLocalizations.of(context)!.couponAlert);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.apply,
                    style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
