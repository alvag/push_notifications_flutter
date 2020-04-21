import 'package:flutter/material.dart';
import 'package:push_notifications_flutter/src/providers/pages/home_page.dart';
import 'package:push_notifications_flutter/src/providers/pages/message_page.dart';
import 'package:push_notifications_flutter/src/providers/push_notifications_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();

    final pushProvider = new PushNotificationsProvider();
    pushProvider.initNotifications();

    pushProvider.messages.listen((data) {
      // Navigator.pushNamed(context, 'message');
      print('MyApp $data');
      navigatorKey.currentState.pushNamed('message', arguments: data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Push Notifications',
      initialRoute: 'home',
      routes: {
        'home': (context) => HomePage(),
        'message': (context) => MessagePage(),
      },
    );
  }
}
