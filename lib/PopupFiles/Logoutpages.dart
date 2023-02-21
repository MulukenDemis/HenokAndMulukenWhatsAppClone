import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mulukenapp/Screens/LoginScreen.dart';

class Logoutpages extends StatefulWidget {
  const Logoutpages({super.key});

  @override
  State<Logoutpages> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Logoutpages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            FirebaseAuth.instance.signOut().then((value) {
              print('user signed out succesfully');
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const LoginScreen();
              }));
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 130, 40, 34),
          ),
          child: const Text(
            'LogOut',
          ),
        ),
      ),
    );
  }
}
