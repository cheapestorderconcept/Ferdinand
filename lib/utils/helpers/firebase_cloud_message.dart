import '../../components/fluttertoast.dart';
import '../../utils/network/accesstoken.dart';
import '../../utils/network/api_request.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class PushNotification {
  void getInitialNotification() async {
    try {
      await Firebase.initializeApp();
      RemoteMessage? initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage?.notification != null) {
        showSimpleNotification(
            Text(
              ' ${initialMessage?.notification?.title}',
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            duration: const Duration(minutes: 3),
            subtitle: Text(
              '${initialMessage?.notification?.body}',
              style: const TextStyle(fontSize: 12, color: Colors.black),
            ),
            background: Colors.white);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  initializeNotification() async {
    try {
      NetworkProvider httpRequest =
          NetworkProvider(authToken: await AccessToken.getToken());
      late final FirebaseMessaging messaging;
      await Firebase.initializeApp();
      messaging = FirebaseMessaging.instance;
      NotificationSettings settings = await messaging.requestPermission();
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        FirebaseMessaging.onMessage.listen((RemoteMessage event) {
          if (event.notification != null) {
            showSimpleNotification(
                Text(
                  ' ${event.notification?.title}',
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                duration: const Duration(minutes: 2),
                subtitle: Text(
                  '${event.notification?.body}',
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                ),
                background: Colors.white);
          }
        });
        String? token = await messaging.getToken();
        print(token);
        httpRequest.call('/client/register-device', RequestMethod.post,
            data: {"token": token});
      } else {
        displayToast(Colors.red, Colors.white,
            'You have disabled notification for the app. Please enable to get updated notification about our services');
      }
    } catch (e) {
        debugPrint(e.toString());
    }
  }
}
