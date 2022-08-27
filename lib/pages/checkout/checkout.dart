import 'package:ferdinand_coffee/core/constants.dart';
import 'package:flutter/material.dart';

class Checkout extends StatelessWidget {
  static const routeName = "/checkout";
  const Checkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.scaffoldColor,
      appBar: AppBar(
        backgroundColor: Constants.scaffoldColor,
        elevation: 0,
        title: const Text(
          'Complete Payment',
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Shipping to',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Black Box Street, Chennai, South India',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '9299883766',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Edit Address',
                        style:
                            TextStyle(fontSize: 12, color: Constants.rustColor),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 20,
            thickness: 7,
            color: Colors.black26,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Payment Methods'),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Radio(value: 1, groupValue: 1, onChanged: (e) {}),
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width / 1.3,
                    decoration: BoxDecoration(
                        color: Constants.primaryColor,
                        borderRadius: BorderRadius.circular(7)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/visa.png',
                            scale: 2.3,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                child: Text('Credit/Debit Card',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13)),
                              ),
                              Text('Pay online ',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10)),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Radio(value: 1, groupValue: 1, onChanged: (e) {}),
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width / 1.3,
                    decoration: BoxDecoration(
                        color: Constants.primaryColor,
                        borderRadius: BorderRadius.circular(7)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/visa.png',
                            scale: 2.3,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                child: Text('Twint',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13)),
                              ),
                              Text('Pay through twint app ',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10)),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ]),
          )
        ],
      ),
    );
  }
}
