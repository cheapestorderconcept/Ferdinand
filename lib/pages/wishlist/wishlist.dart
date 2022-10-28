import 'package:ferdinand_coffee/components/wishlist_product_card.dart';
import 'package:ferdinand_coffee/core/constants.dart';
import 'package:ferdinand_coffee/model/favorites_list.dart';
import 'package:ferdinand_coffee/pages/home/home.dart';
import 'package:ferdinand_coffee/provider/Favorites_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../services/preload/favorites_product.dart';
import '../product_details/product_details.dart';

class WishListPage extends StatefulWidget {
  static const routeName = "/user/wishlist";

  const WishListPage({Key? key}) : super(key: key);

  @override
  State<WishListPage> createState() => _WishListPageState();
}

var future;

class _WishListPageState extends State<WishListPage> {
  MyFavoritesProduct favoritesProduct = MyFavoritesProduct();
  @override
  void initState() {
    future = favoritesProduct.getFavorites(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.scaffoldColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: 25,
          title: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(AppLocalizations.of(context)!.myWishlist)),
          actions: [
            Image.asset('assets/icons/logo.png'),
            const SizedBox(
              width: 30,
            )
          ],
        ),
        body: FutureBuilder<FavoritesProductProvider?>(
          future: future,
          builder: ((context, snapshot) {
            var fav = snapshot.data?.list?.favoriteList;
            if (snapshot.hasData) {
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio:
                        MediaQuery.of(context).size.aspectRatio / 0.7),
                itemCount: fav?.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final product = fav?[index].product;
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return ProductDetailsPage(
                            productDetails: {
                              "productId": product?.sId,
                            },
                          );
                        }),
                      );
                    },
                    child: WishListProductCard(
                      productId: fav?[index].sId,
                      productName: fav?[index].product?.productName,
                      productPicture: fav?[index].product?.productPictures,
                      productPrice:
                          fav?[index].product?.productVariants?[0].price,
                    ),
                  );
                },
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text(
                  AppLocalizations.of(context)!.loading,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            } else {
              return Center(
                child: Text(
                  AppLocalizations.of(context)!.noWishlist,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }
          }),
        ));
  }
}
