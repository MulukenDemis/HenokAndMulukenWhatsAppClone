import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:mulukenapp/PopupFiles/Logoutpages.dart';
import 'package:mulukenapp/PopupFiles/Setting.dart';
import 'package:mulukenapp/PopupFiles/linkedDevicesPage.dart';
import 'package:mulukenapp/PopupFiles/newBroadcastPage.dart';
import 'package:mulukenapp/PopupFiles/newGroupPage.dart';
import 'package:mulukenapp/PopupFiles/starredMessagesPage.dart';
import 'package:mulukenapp/Screens/LoginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/Settings': (context) => SettingPage(),
        '/newGroup': (context) => NewGroupPage(),
        '/newBroadcast': (context) => const NewBroadcastPage(),
        '/linkedDevices': (context) => const linkedDevicesPage(),
        '/starredMessages': (context) => const StarredMessagePage(),
        '/Logoutpages': (context) => const Logoutpages(),
      },
      //),
    );
  }
}
