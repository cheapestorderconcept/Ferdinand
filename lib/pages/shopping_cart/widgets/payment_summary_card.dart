import 'package:ferdinand_coffee/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../provider/cart.dart';
import '../../../provider/shipping_address_provider.dart';
import '../../../services/auth/add_shipping_address.dart';

class PaymentSummary extends StatefulWidget {
  const PaymentSummary({Key? key}) : super(key: key);

  @override
  _PaymentSummaryState createState() => _PaymentSummaryState();
}

class _PaymentSummaryState extends State<PaymentSummary> {
  @override
  void initState() {
    final GetShippingAddress shippingAddress = GetShippingAddress();
    shippingAddress.getShippingAddress(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final totalAmount = context.read<CartProvider>().totalAmount;
    final shippingInfo =
        context.read<ShippingAddressProvider>().shippingAddress;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Container(
        // height: 130,
        color: Constants.orangeColor.withOpacity(0.03),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 28,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.subTotal,
                      style: const TextStyle(
                          fontSize: 12,
                          color: Constants.greyColor,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      // width: 52,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'CHF: ${context.watch<CartProvider>().totalAmount.toStringAsFixed(2)}',
                            // textDirection: TextDirection.ltr,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Constants.greyColor,
                                fontWeight: FontWeight.w500),
                          ),
                          const Text(
                            '',
                            // textDirection: TextDirection.ltr,
                            style: TextStyle(
                                fontSize: 12,
                                color: Constants.greyColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 28,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.tax,
                      style: const TextStyle(
                          fontSize: 12,
                          color: Constants.greyColor,
                          fontWeight: FontWeight.w400),
                    ),
                    Container(
                      // width: 52,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          //making deliver free irrespective of amount purchased
                          Text(
                            'CHF ${totalAmount < 150 ? Constants.postalCode.contains(shippingInfo?.zipCode) ? '0' : '0' : '0'}',
                            textAlign: TextAlign.end,
                            // textDirection: TextDirection.ltr,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Constants.greyColor,
                                fontWeight: FontWeight.w500),
                          ),
                          const Text(
                            "",
                            textAlign: TextAlign.start,
                            // textDirection: TextDirection.ltr,
                            style: TextStyle(
                                fontSize: 12,
                                color: Constants.greyColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // !true
            //     // ignore: dead_code
            //     ? Container()
            //     : Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Container(
            //           height: 28,
            //           padding: const EdgeInsets.symmetric(horizontal: 20),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Text(
            //                 'Discount',
            //                 style: TextStyle(
            //                     fontSize: 12,
            //                     color: Constants.orangeColor.withOpacity(1),
            //                     fontWeight: FontWeight.w400),
            //               ),
            //               Container(
            //                 // width: 52,
            //                 alignment: Alignment.center,
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.end,
            //                   children: [
            //                     Text(
            //                       'CHF ' + 33.toString(),
            //                       textAlign: TextAlign.end,
            //                       // textDirection: TextDirection.ltr,
            //                       style: const TextStyle(
            //                           fontSize: 12,
            //                           color: Constants.orangeColor,
            //                           fontWeight: FontWeight.w500),
            //                     ),
            //                     const Text(
            //                       '',
            //                       textAlign: TextAlign.start,
            //                       // textDirection: TextDirection.ltr,
            //                       style: TextStyle(
            //                           fontSize: 12,
            //                           color: Constants.orangeColor,
            //                           fontWeight: FontWeight.w500),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            const Divider(
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 30,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.grandTotal,
                      style: const TextStyle(
                          fontSize: 12,
                          color: Constants.greyColor,
                          fontWeight: FontWeight.w700),
                    ),
                    Container(
                      // width: 52,
                      // color: Colors.red,
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${totalAmount < 150 ? Constants.postalCode.contains(shippingInfo?.zipCode) ? num.parse(context.watch<CartProvider>().totalAmount.toStringAsFixed(2)) + 0 : num.parse(context.watch<CartProvider>().totalAmount.toStringAsFixed(2)) + 0 : num.parse(context.watch<CartProvider>().totalAmount.toStringAsFixed(2)) + 0}',
                            // textDirection: TextDirection.ltr,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Constants.orangeColor,
                                fontWeight: FontWeight.w700),
                          ),
                          const Text(
                            '',
                            // textDirection: TextDirection.ltr,
                            style: TextStyle(
                                fontSize: 12,
                                color: Constants.orangeColor,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
