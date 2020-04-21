import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsProvider {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _messagesStreamCtrl = StreamController<String>.broadcast();
  Stream<String> get messages => _messagesStreamCtrl.stream;

  initNotifications() {
    _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.getToken().then((token) {
      print('==== FCM TOKEN ====');
      print(token);

      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print('onMessage $message');
          String arg = 'no-data';
          if (Platform.isAndroid) {
            arg = message['data']['comida'] ?? 'no-data';
          }
          _messagesStreamCtrl.sink.add(arg);
        },
        onLaunch: (Map<String, dynamic> message) async {
          print('onLaunch $message');
        },
        onResume: (Map<String, dynamic> message) async {
          print('onResume $message');

          final notification = message['data']['comida'];
          _messagesStreamCtrl.sink.add(notification);
        },
      );
    });
  }

  dispose() {
    _messagesStreamCtrl?.close();
  }
}
