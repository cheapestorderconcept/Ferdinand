import 'package:ferdinand_coffee/core/constants.dart';
import 'package:ferdinand_coffee/pages/add_new_address/add_new_address.dart';
import 'package:flutter/material.dart';

class SelectDeliveryAddress extends StatefulWidget {
  static const routeName = "/cart/select_delivery_address";

  const SelectDeliveryAddress({Key? key}) : super(key: key);

  @override
  State<SelectDeliveryAddress> createState() => _SelectDeliveryAddressState();
}

class _SelectDeliveryAddressState extends State<SelectDeliveryAddress> {
  int? currentAddress;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.scaffoldColor,
      appBar: AppBar(
        backgroundColor: Constants.scaffoldColor,
        elevation: 0,
        title: const Text(
          'Select Delivery Address',
          style: TextStyle(color: Colors.white, fontSize: 14),
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
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () async {
              Navigator.pushNamed(context, AddNewAddress.routeName);
            },
            child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Constants.primaryColor.withOpacity(0.3),
                      blurRadius: 5,
                      spreadRadius: 1)
                ], shape: BoxShape.circle, color: Constants.orangeColor),
                child: const Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                  size: 39,
                )),
          ),
          const SizedBox(height: 20),
          true
              ? GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, routeName)
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    height: 54,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Constants.orangeColor.withOpacity(0.3),
                            blurRadius: 5,
                            spreadRadius: 1)
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: Constants.orangeColor,
                    ),
                    child: const Center(
                        child: Text('Complete Payment',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700))),
                  ),
                )
              // ignore: dead_code
              : Container()
        ],
      ),
      body: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: 4,
          separatorBuilder: (c, i) => const SizedBox(height: 20),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                currentAddress = index;
                setState(() {});
              },
              child: Container(
                // height: 120,
                decoration: BoxDecoration(
                    border: currentAddress == index
                        ? Border.all(width: 1, color: Constants.orangeColor)
                        : null,
                    borderRadius: BorderRadius.circular(4),
                    color: const Color.fromRGBO(56, 41, 41, 1)),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/images/temp/map.png'),
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('John Doe',
                                      style: TextStyle(color: Colors.white)),
                                ],
                              ),
                              const Text('Mount Views, New york , USA, 18003',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10)),
                              const SizedBox(
                                height: 4,
                              ),
                              const Text('+91 - 791234343',
                                  style: TextStyle(
                                      color: Constants.orangeColor,
                                      fontSize: 10))
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            );
          }),
    );
  }
}
