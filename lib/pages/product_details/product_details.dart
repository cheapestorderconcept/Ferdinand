import 'package:ferdinand_coffee/components/fluttertoast.dart';
import 'package:ferdinand_coffee/components/mainsubmitbutton.dart';
import 'package:ferdinand_coffee/core/constants.dart';
import 'package:ferdinand_coffee/model/singleproduct_details.dart';
import 'package:ferdinand_coffee/pages/home/home.dart';
import 'package:ferdinand_coffee/pages/shopping_cart/shopping_cart.dart';
import 'package:ferdinand_coffee/provider/cart.dart';
import 'package:ferdinand_coffee/provider/product_Details.dart';
import 'package:ferdinand_coffee/utils/helpers/fetch_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/cart_model.dart';
import '../../provider/product_provider2.dart';
import '../../services/order/add_to_favorites.dart';
import '../../services/preload/product.dart';

//check if the product has been added, if it has been added prevent duplication
class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({Key? key, this.productDetails}) : super(key: key);
  static const routeName = "/productdetails";
  final Map<String, dynamic>? productDetails;
  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

bool is500g = true;
num? productPrice;
String? productType;
int currentItemSelected = 0;
var future;

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  void initState() {
    SingleProductDetails product = SingleProductDetails();
    future = product.fetchProduct(context, widget.productDetails?['productId']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final itemSelected = context.watch<ProductProvider>().itemSelected;
    return WillPopScope(
      onWillPop: () async {
        Provider.of<CartProvider>(context, listen: false).resetQty = 1;
        context.read<ProductProvider>().selectedgram(null);
        return Future.value(true);
      },
      child: Scaffold(
          backgroundColor: Constants.scaffoldColor,
          appBar: MyAppBar(
            title: AppLocalizations.of(context)!.productDetails,
            image: 'assets/icons/logo.png',
          ),
          body: FutureBuilder<ProductDetailsProvider?>(
              future: future,
              builder: (context, snapShot) {
                if (snapShot.hasData) {
                  final product = snapShot.data!.product?.data?.product;
                  return ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin:
                                const EdgeInsets.only(bottom: 10, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(child: Container()),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: fetchImage(
                                      '${Constants.baseUrl}/admin/download-image/${product?.productPictures}/${Constants.imageBucket}',
                                      200,
                                      200,
                                      false),
                                ),
                                Expanded(child: Container()),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 20, bottom: 20),
                            child: RichText(
                              text: TextSpan(
                                  text: product?.productName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                  children: [
                                    const TextSpan(
                                      text: 'CHF ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10,
                                        height: 2,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          '${itemSelected != null ? context.read<CartProvider>().myProductPrice : ''}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                          Container(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 20),
                            child: Selector<ProductProvider, int?>(
                                selector: (context, value) =>
                                    value.itemSelected,
                                builder: (context, value, child) {
                                  final itemSelected = context
                                      .watch<ProductProvider>()
                                      .itemSelected;
                                  return Row(
                                    children: List.generate(
                                        int.parse(
                                            '${product?.productVariants!.length}'),
                                        (index) {
                                      return SelectGram(
                                        bordercolor: value == itemSelected
                                            ? Colors.white
                                            : Colors.transparent,
                                        selectedgram:
                                            '${product?.productVariants?[index].name}',
                                        function: () {
                                          //allow product quantity if selected gram is 10x500g
                                          Provider.of<CartProvider>(context,
                                                      listen: false)
                                                  .productPrice =
                                              num.parse(
                                                  '${product?.productVariants?[index].priceWithVat}');

                                          context
                                              .read<ProductProvider>()
                                              .selectedgram(index);

                                          setState(() {
                                            currentItemSelected = index;
                                            productType = product
                                                ?.productVariants?[index].name;
                                          });

                                          if (productType == '10x500g') {
                                            context
                                                .read<CartProvider>()
                                                .resetQty = 1;
                                          } else {
                                            context
                                                .read<CartProvider>()
                                                .resetQty = 1;
                                          }
                                        },
                                        color: index == itemSelected
                                            ? Constants.greenColor
                                            : Colors.transparent,
                                      );
                                    }),
                                  );
                                }),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 20),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    ProductPackagedetails(
                                      productpackagedetail:
                                          AppLocalizations.of(context)!
                                              .packaging,
                                    ),
                                    const SizedBox(width: 20),
                                    ProductPackagedetails(
                                        productpackagedetail:
                                            AppLocalizations.of(context)!
                                                .organicCoffee)
                                  ],
                                ),
                                const SizedBox(height: 10),
                                ProductPackagedetails(
                                  productpackagedetail:
                                      AppLocalizations.of(context)!
                                          .fastDelivery,
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: RichText(
                              // textAlign: TextAlign.justify,
                              text: TextSpan(
                                  text: 'Beschreibung\n',
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '${product?.productDescription}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        wordSpacing: 2.0,
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MainSubmitButton(
                              function: () {
                                AddProductToFavoritesList favoritesList =
                                    AddProductToFavoritesList();

                                favoritesList.addToFavorites(
                                    product?.sId, context);
                              },
                              buttonlabel:
                                  AppLocalizations.of(context)!.addFavorites),
                          const SizedBox(
                            height: 10,
                          ),
                          Selector<ProductProvider, bool>(
                              selector: (
                                context,
                                value,
                              ) =>
                                  value.showbuttombar,
                              builder: (context, value, child) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 30,
                                  ),
                                  color: Constants.primaryColor,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          context
                                              .read<CartProvider>()
                                              .decreaseQty();
                                        },
                                        child: const CircleAvatar(
                                          child: Icon(Icons.remove),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.03,
                                      ),
                                      Selector<CartProvider, int>(
                                        selector: (
                                          context,
                                          value,
                                        ) =>
                                            value.qty,
                                        builder: (context, value, child) {
                                          return Text(
                                            value.toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        width: width * 0.03,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          context
                                              .read<CartProvider>()
                                              .increseQty();
                                        },
                                        child: const CircleAvatar(
                                          child: Icon(Icons.add),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(),
                                      ),
                                      MainSubmitButton(
                                        buttonheight: 40,
                                        function: () {
                                          final items =
                                              context.read<CartProvider>().item;
                                          if (items
                                              .containsKey('$productType')) {
                                            displayToast(
                                                Colors.red,
                                                Colors.white,
                                                AppLocalizations.of(context)!
                                                    .cartError);
                                          } else {
                                            context
                                                    .read<CartProvider>()
                                                    .qtyPurchased =
                                                context
                                                    .read<CartProvider>()
                                                    .qty;
                                            if (context
                                                    .read<CartProvider>()
                                                    .myProductPrice ==
                                                0) {
                                              displayToast(
                                                  Colors.red,
                                                  Colors.white,
                                                  AppLocalizations.of(context)!
                                                      .variantsError);
                                            } else {
                                              if (productType == '10x500g') {
                                                context
                                                    .read<CartProvider>()
                                                    .set10x500g = true;
                                              } else {
                                                context
                                                    .read<CartProvider>()
                                                    .set10x500g = false;
                                              }

                                              CartModel item = CartModel(
                                                  productVat: num.parse(
                                                          '${product?.productVariants?[currentItemSelected].priceWithVat}') -
                                                      num.parse(
                                                          '${product?.productVariants?[currentItemSelected].price}'),
                                                  vat: num.parse('${product?.vat}') *
                                                      (context
                                                              .read<
                                                                  CartProvider>()
                                                              .myProductPrice *
                                                          context
                                                              .read<
                                                                  CartProvider>()
                                                              .qty),
                                                  productId: product?.sId,
                                                  itemId: '$productType',
                                                  itemPrice: context
                                                      .read<CartProvider>()
                                                      .myProductPrice,
                                                  productName:
                                                      product?.productName,
                                                  productQty: context
                                                      .read<CartProvider>()
                                                      .qty,
                                                  totalPrice: context
                                                          .read<CartProvider>()
                                                          .myProductPrice *
                                                      context.read<CartProvider>().qty,
                                                  image: product?.productPictures,
                                                  selectedGram: '');
                                              Provider.of<CartProvider>(context,
                                                      listen: false)
                                                  .addItems = item;
                                              alertdialogmethod(context, width);

                                              context
                                                  .read<ProductProvider>()
                                                  .togglebuttombartofalse();
                                            }
                                          }
                                        },
                                        buttonlabel:
                                            AppLocalizations.of(context)!
                                                .addToCart,
                                        buttonwidth: width * 0.4,
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ],
                      ),
                    ],
                  );
                } else if (snapShot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: Text(
                      AppLocalizations.of(context)!.loading,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                } else {
                  return const Center(
                    child: Text(
                      'Produkt nicht gefunden. Pr??fe deine Internetverbindung',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                }
              })),
    );
  }
}

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  const MyAppBar({
    Key? key,
    this.preferredSize = const Size(20, 70),
    this.image,
    this.bottom,
    required this.title,
  }) : super(key: key);

  final PreferredSizeWidget? bottom;
  final String title;
  final String? image;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      bottom: bottom,
      elevation: 0,
      leadingWidth: 25,
      title: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(title)),
      actions: [
        Image.asset(
          image ?? 'assets/icons/logo.png',
          scale: 6,
        ),
        const SizedBox(
          width: 15,
        )
      ],
    );
  }
}

Future alertdialogmethod(BuildContext context, double width) {
  return showDialog(
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.only(left: 12, right: 12, top: 300),
          child: AlertDialog(
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            backgroundColor: Constants.deepBrownColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: Builder(
              builder: (context) {
                return SizedBox(
                  height: 250,
                  width: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            width: 2,
                            color: Colors.white,
                          ),
                        ),
                        child: const CircleAvatar(
                          radius: 2,
                          backgroundColor: Constants.lightbrown,
                          child: Icon(
                            Icons.done,
                            // size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.productAdded,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MainSubmitButton(
                            buttonheight: 50,
                            function: () {
                              Provider.of<CartProvider>(context, listen: false)
                                  .resetQty = 1;
                              context
                                  .read<ProductProvider>()
                                  .togglebuttombartotrue();
                              Navigator.pushNamed(
                                context,
                                ShoppingCart.routeName,
                              );
                            },
                            buttonlabel: AppLocalizations.of(context)!.checkOut,
                            buttonwidth: width * 0.4,
                          ),
                          MainSubmitButton(
                            buttontextcolor: Colors.black,
                            buttoncolor: Constants.buttoncolor,
                            buttonheight: 50,
                            function: () {
                              Provider.of<CartProvider>(context, listen: false)
                                  .resetQty = 1;
                              context
                                  .read<ProductProvider>()
                                  .togglebuttombartotrue();
                              Navigator.pushNamed(
                                context,
                                HomePage.routeName,
                              );
                            },
                            buttonlabel:
                                AppLocalizations.of(context)!.discoverMore,
                            buttonwidth: width * 0.4,
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        );
      });
}

class SelectGram extends StatelessWidget {
  const SelectGram({
    required this.selectedgram,
    required this.function,
    required this.color,
    required this.bordercolor,
    Key? key,
  }) : super(key: key);

  final String selectedgram;
  final Function() function;
  final Color color;
  final Color bordercolor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            width: 0.3,
            color: bordercolor,
          ),
        ),
        child: Text(
          selectedgram,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ProductPackagedetails extends StatelessWidget {
  const ProductPackagedetails({
    required this.productpackagedetail,
    Key? key,
  }) : super(key: key);
  final String productpackagedetail;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 5,
          backgroundColor: Constants.greenColor,
          child: Icon(
            Icons.done,
            size: 10,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 3),
        Text(
          productpackagedetail,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
