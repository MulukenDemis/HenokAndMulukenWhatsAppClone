import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mulukenapp/Components/Communities.dart';
import 'package:mulukenapp/Components/WhatsAppUI.dart';

import 'package:mulukenapp/Screens/authentication.dart';
import 'package:mulukenapp/Screens/facebooklogin.dart';

import 'package:mulukenapp/reUsableWidgets/textFeilds.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  bool _isSigningIn = false;
  late Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 7),
              color: Color.fromARGB(255, 91, 186, 94),
              height: size.height * 0.13,
              width: double.infinity,
              child: Image.asset('assets/whatsapplogo1.png'),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'Create a New Account',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            reUsableTextFeild('Enter UserName', Icons.person_outline, false,
                _userNameTextController),
            const SizedBox(
              height: 5,
            ),
            reUsableTextFeild(
                'Enter Email', Icons.email, false, _emailTextController),
            const SizedBox(
              height: 5,
            ),
            reUsableTextFeild(
                'Enter password', Icons.lock, false, _passwordTextController),
            const SizedBox(
                // height: MediaQuery.of(context).size. * 0.05,
                ),
            Buttons(context, false, () {
              FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text)
                  .then((value) {
                print('Successfully created new account');
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return WhatsAppUi();
                }));
              }).onError((error, stackTrace) {
                print('Error $error');
              });
            }),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  primary: Color.fromARGB(255, 193, 172, 172),
                  onPrimary: Colors.black,
                  minimumSize: const Size(double.infinity / 15, 50),
                ),
                label: const Text('Sign up  with Google'),
                icon: const FaIcon(
                  FontAwesomeIcons.google,
                  color: Color.fromARGB(255, 117, 35, 29),
                ),
                onPressed: () async {
                  setState(() {
                    _isSigningIn = true;
                  });

                  User? user =
                      await Authentication.signInWithGoogle(context: context);

                  setState(() {
                    _isSigningIn = false;
                  });

                  if (user != null) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => WhatsAppUi(),
                      ),
                    );
                  }
                }),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  primary: Color.fromARGB(255, 227, 207, 207),
                  onPrimary: Colors.black,
                  minimumSize: const Size(double.infinity / 10, 50)),
              onPressed: () async {
                setState(() {
                  _isSigningIn = true;
                });
                Future<String?> user = facebookSignin(context: context);

                setState(() {
                  _isSigningIn = false;
                });
              },
              label: const Text('Sign up  with facebook'),
              icon: const FaIcon(
                FontAwesomeIcons.facebook,
                color: Color.fromARGB(255, 15, 69, 113),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
