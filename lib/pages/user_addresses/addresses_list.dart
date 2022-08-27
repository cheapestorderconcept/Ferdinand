import 'package:ferdinand_coffee/core/constants.dart';
import 'package:ferdinand_coffee/pages/add_new_address/add_new_address.dart';
import 'package:flutter/material.dart';

class UserAddressesList extends StatelessWidget {
  static const routeName = "/addresses/list";

  const UserAddressesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.scaffoldColor,
      appBar: AppBar(
        backgroundColor: Constants.scaffoldColor,
        elevation: 0,
        title: const Text(
          'My Addressses',
          style: TextStyle(color: Colors.white, fontSize: 20),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constants.orangeColor,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, AddNewAddress.routeName);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: 4,
          separatorBuilder: (c, i) => const SizedBox(height: 20),
          itemBuilder: (context, index) {
            return Container(
              // height: 120,
              decoration: BoxDecoration(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('John Doe',
                                    style: TextStyle(color: Colors.white)),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: Image.asset(
                                      'assets/icons/delete_wishlist_item.png',
                                      scale: 1.9),
                                )
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
                                    color: Constants.orangeColor, fontSize: 10))
                          ],
                        ),
                      ))
                ],
              ),
            );
          }),
    );
  }
}
