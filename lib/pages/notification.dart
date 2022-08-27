import 'package:ferdinand_coffee/core/constants.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  static const routeName = "/notifications";
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.scaffoldColor,
      appBar: AppBar(
        backgroundColor: Constants.scaffoldColor,
        elevation: 0,
        title: const Text(
          'Notifications',
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/no_notification.png'),
      const      Text('No New Notifications!', style: TextStyle(color: Colors.white))
          ],
        ),
      ),
    );
  }
}
