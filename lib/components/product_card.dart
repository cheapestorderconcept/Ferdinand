import 'package:ferdinand_coffee/core/constants.dart';
import 'package:ferdinand_coffee/utils/helpers/fetch_image.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  ProductCard(
      {Key? key,
      this.productName,
      this.productId,
      this.productPicture,
      this.onTap,
      this.productPrice})
      : super(key: key);

  String? productName;
  String? productPicture;
  String? productPrice;
  String? productId;
  Function()? onTap;
  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool? isLiked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        // height: 170,
        width: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Constants.primaryColor,
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(113, 55, 55, 0.16),
                blurRadius: 10,
                spreadRadius: 2),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              fetchImage('${widget.productPicture}', 100, 100, false),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 6,
                    ),
                    SizedBox(
                      width: 230,
                      child: Text('${widget.productName}',
                          style: const TextStyle(
                              fontSize: 10, color: Colors.white)),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            const Text('CHF. ',
                                style: TextStyle(color: Colors.white)),
                            Text(
                              '${widget.productPrice}',
                              style: const TextStyle(
                                  color: Constants.rustColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class GridViewProductCard extends StatefulWidget {
//   const GridViewProductCard({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<GridViewProductCard> createState() => _GridViewProductCardState();
// }

// class _GridViewProductCardState extends State<GridViewProductCard> {
//   bool isLiked = false;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(4),
//         color: Constants.primaryColor,
//         boxShadow: const [
//           BoxShadow(
//               color: Color.fromRGBO(113, 55, 55, 0.16),
//               blurRadius: 10,
//               spreadRadius: 2),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       isLiked = !isLiked;
//                     });
//                   },
//                   child: !isLiked
//                       ? Image.asset(
//                           'assets/icons/heart_outlined.png',
//                           scale: 2.3,
//                         )
//                       : Image.asset(
//                           'assets/icons/heart_liked.png',
//                           scale: 4.1,
//                         ),
//                 ),
//               ],
//             ),
//             Image.asset(
//               'assets/images/temp/coffee_pack.png',
//               scale: 1.8,
//             ),
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   const SizedBox(
//                     height: 6,
//                   ),
//                   const Text('Liri House Blend / Kaffeebohnen',
//                       style: TextStyle(fontSize: 12, color: Colors.white)),
//                   const SizedBox(
//                     height: 7,
//                   ),
//                   Row(
//                     children: [
//                       Row(
//                         children: const [
//                           Text('CHF. ', style: TextStyle(color: Colors.white)),
//                           Text(
//                             '21',
//                             style: TextStyle(
//                                 color: Constants.rustColor,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
