import 'package:ferdinand_coffee/utils/helpers/fetch_image.dart';
import 'package:flutter/material.dart';

import '../core/constants.dart';

class OrderPlacementCard extends StatelessWidget {
  const OrderPlacementCard(
      {Key? key,
      this.status,
      this.referenceNumber,
      this.image,
      this.orderDate,
      this.arrivedBy,
      this.productName})
      : super(key: key);
  final String? referenceNumber;
  final String? status;
  final String? orderDate;
  final String? productName;
  final String? image;
  final String? arrivedBy;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromRGBO(56, 41, 41, 1),
          borderRadius: BorderRadius.circular(8)),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          fetchImage(
              '${Constants.baseUrl}/admin/download-image/$image/${Constants.imageBucket}',
              50,
              50,
              false),
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 170,
                        child: Text('$productName',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      Text(
                        '$orderDate',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      const Text('Reference number: ',
                          style: TextStyle(color: Colors.white, fontSize: 10)),
                      Text(
                        '$referenceNumber',
                        style: const TextStyle(
                          color: Constants.orangeColor,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      const Text('Status: ',
                          style: TextStyle(color: Colors.white, fontSize: 10)),
                      Text('$status',
                          style: const TextStyle(
                            color: Constants.orangeColor,
                            fontSize: 10,
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text('Arriving by: ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10)),
                          Text(arrivedBy ?? 'N/A',
                              style: const TextStyle(
                                color: Constants.orangeColor,
                                fontSize: 10,
                              )),
                        ],
                      ),
                      // Row(
                      //   children: const [
                      //     Text('Show more',
                      //         style: TextStyle(
                      //           color: Constants.orangeColor,
                      //           fontSize: 10,
                      //         )),
                      //     Icon(
                      //       Icons.arrow_forward_ios,
                      //       color: Constants.orangeColor,
                      //       size: 15,
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
