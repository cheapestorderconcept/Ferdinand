import 'package:ferdinand_coffee/components/mainsubmitbutton.dart';
import 'package:ferdinand_coffee/core/constants.dart';
import 'package:ferdinand_coffee/pages/shopping_cart/widgets/coupon.dart';
import 'package:ferdinand_coffee/pages/shopping_cart/widgets/payment_summary_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ferdinand_coffee/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/fluttertoast.dart';
import '../../provider/shipping_address_provider.dart';
import '../../services/order/payment.dart';
import '../../services/order/place_order.dart';

class ShoppingCart extends StatefulWidget {
  static const routeName = "/cart";

  const ShoppingCart({Key? key}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

String? discountCode;
String? redeemPoints;

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    final shippingInfo =
        context.read<ShippingAddressProvider>().shippingAddress;
    final items = context.watch<CartProvider>().item;

    return Scaffold(
      backgroundColor: Constants.scaffoldColor,
      appBar: AppBar(
        backgroundColor: Constants.scaffoldColor,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.cartTitle,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.asset(
              'assets/icons/logo.png',
              scale: 6,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            ...items.values.map((e) {
              final vat = e.productVat! * e.productQty!;
              return Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.only(left: 10, bottom: 15, right: 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(56, 41, 41, 1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 28),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 70,
                            child: Image.asset(
                              'assets/images/temp/coffee_pack.png',
                              scale: 1,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${e.productName}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Price: ${e.totalPrice}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(width: 5),
                                  SizedBox(
                                    height: 100,
                                    child: Column(children: [
                                      Text(
                                        '${vat.toStringAsFixed(2)}% Mwst',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ]),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(
                          height: 2,
                        ),
                        InkWell(
                          onTap: () {
                            final totalItems =
                                context.read<CartProvider>().item.length;
                            if (totalItems > 0) {
                              //
                              context.read<CartProvider>().removeItems =
                                  '${e.itemId}';
                            } else {
                              displayToast(
                                  Colors.red,
                                  Colors.white,
                                  AppLocalizations.of(context)!
                                      .cartRemovalError);
                            }
                          },
                          child: Image.asset(
                            'assets/icons/delete_wishlist_item.png',
                            scale: 1.3,
                          ),
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                context
                                    .read<CartProvider>()
                                    .decreaseItemInCartQty = '${e.itemId}';
                                context.read<CartProvider>().qtyPurchased = -1;
                              },
                              child: const Icon(
                                Icons.remove,
                                color: Colors.grey,
                                size: 22,
                              ),
                            ),
                            Text(
                              '  ${e.productQty} ',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white),
                            ),
                            InkWell(
                              onTap: () {
                                context
                                    .read<CartProvider>()
                                    .increaseItemInCartQty('${e.itemId}');
                                context.read<CartProvider>().qtyPurchased = 1;
                              },
                              child: const Icon(
                                Icons.add,
                                color: Constants.rustColor,
                                size: 22,
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              );
            }),
            Coupon(
              hintText: AppLocalizations.of(context)!.couponCode,
              couponController: (v) {
                discountCode = v;
              },
            ),
            const SizedBox(height: 10),
            Coupon(
              hintText: AppLocalizations.of(context)!.redeemPoints,
              couponController: (v) {
                redeemPoints = v;
              },
            ),
            const PaymentSummary(),
            MainSubmitButton(
              function: () async {
                final totalQty = context.read<CartProvider>().totalQtyPurchases;
                final is10x500g = context.read<CartProvider>().is10x500g;
                if (totalQty >= 2 || is10x500g == true) {
                  final total = context.read<CartProvider>().totalAmount;
                  final totalAmountToPay = total < 150
                      ? Constants.postalCode.contains(shippingInfo?.zipCode)
                          ? num.parse(context
                                  .watch<CartProvider>()
                                  .totalAmount
                                  .toStringAsFixed(2)) +
                              8
                          : context.read<CartProvider>().totalAmount + 0
                      : num.parse(context
                              .watch<CartProvider>()
                              .totalAmount
                              .toStringAsFixed(2)) +
                          0;
                  final cartProducts =
                      items.values.map((e) => e.toJson()).toList();
                  PaymentApi paymentApi = PaymentApi();
                  String? clientSecret = await paymentApi.initiatePayment(
                      totalAmountToPay, discountCode, redeemPoints, context);
                  if (clientSecret != null) {
                    PaymentSheet paymentSheet = PaymentSheet();
                    bool paymentSuccessful =
                        await paymentSheet.displayPaymentSheet(context);
                    if (!!paymentSuccessful) {
                      PlaceOrder placeOrder = PlaceOrder();
                      placeOrder.placeOrder(cartProducts, context);
                    }
                  } else {
                    displayToast(Colors.red, Colors.white,
                        AppLocalizations.of(context)!.paymentResponse);
                  }
                } else {
                  displayToast(Colors.red, Colors.white,
                      AppLocalizations.of(context)!.checkoutError);
                }
              },
              buttonlabel: AppLocalizations.of(context)!.checkOut,
            ),
            const SizedBox(height: 15),
            MainSubmitButton(
                function: () {
                  Provider.of<CartProvider>(context, listen: false).clearCart =
                      {};
                  Navigator.pop(context);
                },
                buttonlabel: AppLocalizations.of(context)!.clearCart),
          ],
        ),
      ),
    );
  }
}
