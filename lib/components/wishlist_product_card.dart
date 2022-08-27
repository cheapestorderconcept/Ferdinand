import 'package:ferdinand_coffee/core/constants.dart';
import 'package:ferdinand_coffee/services/preload/favorites_product.dart';
import 'package:ferdinand_coffee/utils/helpers/fetch_image.dart';

import 'package:flutter/material.dart';

class WishListProductCard extends StatelessWidget {
  const WishListProductCard(
      {Key? key,
      this.productName,
      this.productId,
      this.productPicture,
      this.productPrice})
      : super(key: key);

  final String? productName;
  final String? productPicture;
  final String? productId;
  final num? productPrice;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Constants.primaryColor,
        boxShadow: const [
          BoxShadow(
              color: Color.fromRGBO(113, 55, 55, 0.16),
              blurRadius: 6,
              spreadRadius: 2),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    DeleteFavoritesProduct _delete = DeleteFavoritesProduct();
                    _delete.deleteFavorties(productId, context);
                  },
                  child: Image.asset(
                    'assets/icons/delete_wishlist_item.png',
                    scale: 1.2,
                  ),
                ),
              ],
            ),
            fetchImage(
                '${Constants.baseUrl}/admin/download-image/$productPicture/${Constants.imageBucket}',
                100,
                100,
                false),
            const SizedBox(
              height: 16,
            ),
            Text('$productName',
                style: const TextStyle(fontSize: 12, color: Colors.white)),
            const SizedBox(
              height: 7,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text('SFr. ',
                          style: TextStyle(color: Colors.white)),
                      Text(
                        '$productPrice',
                        style: const TextStyle(
                            color: Constants.rustColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/icons/add_to_cart.png',
                    scale: 1.8,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
