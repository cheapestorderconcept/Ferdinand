import 'package:ferdinand_coffee/core/constants.dart';
import 'package:flutter/material.dart';

class ViewPlacedOrder extends StatelessWidget {
  static const routeName = "/admin/placed-orders";

  const ViewPlacedOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.scaffoldColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 25,
        title: const Text('Placed Order', style: TextStyle()),
        actions: [
          Image.asset(
            'assets/icons/logo.png',
            scale: 6,
          ),
          const SizedBox(
            width: 15,
          )
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
                color: const Color.fromRGBO(56, 41, 41, 1),
                borderRadius: BorderRadius.circular(8)),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/temp/coffee_pack.png',
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            SizedBox(
                              width: 170,
                              child: Text('Liri House Blend / coffee beans',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            Text('21 June 2021',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: const [
                            Text('Reference number: ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10)),
                            Text('5585783887',
                                style: TextStyle(
                                  color: Constants.orangeColor,
                                  fontSize: 10,
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: const [
                            Text('Status: ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10)),
                            Text('Ready to Ship',
                                style: TextStyle(
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
                              children: const [
                                Text('Arriving by: ',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10)),
                                Text('3 Dec',
                                    style: TextStyle(
                                      color: Constants.orangeColor,
                                      fontSize: 10,
                                    )),
                              ],
                            ),
                            Row(
                              children: const [
                                Text('Show more',
                                    style: TextStyle(
                                      color: Constants.orangeColor,
                                      fontSize: 10,
                                    )),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Constants.orangeColor,
                                  size: 15,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (c, i) => const SizedBox(
          height: 20,
        ),
        itemCount: 4,
      ),
    );
  }
}
