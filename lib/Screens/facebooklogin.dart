import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:mulukenapp/Components/WhatsAppUI.dart';

import 'SignupScreen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<String?> facebookSignin({required BuildContext context}) async {
  try {
    final _instance = FacebookAuth.instance;
    final result = await _instance.login(permissions: ['email']);
    if (result.status == LoginStatus.success) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => WhatsAppUi(),
        ),
      );

      final OAuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken!.token);
      final credentials = await _auth.signInWithCredential(credential);
      await _instance.getUserData().then((userData) async {
        await _auth.currentUser!.updateEmail(userData['email']);
      });
      return null;
    } else if (result.status == LoginStatus.cancelled) {
      return 'Login cancelled';
    } else {
      return 'Error';
    }
  } catch (e) {
    return e.toString();
  }
}















// // user.dart

// import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

// class UserScreen extends StatefulWidget {
//   const UserScreen({Key? key}) : super(key: key);

//   @override
//   State<UserScreen> createState() => _UserScreenState();
// }

// class _UserScreenState extends State<UserScreen> {
//   Map<String, dynamic>? _userData;
//   AccessToken? _accessToken;
//   bool? _checking = true;

//   _ifUserIsLoggedIn() async {
//     final accessToken = await FacebookAuth.instance.accessToken;

//     setState(() {
//       _checking = false;
//     });

//     if (accessToken != null) {
//       final userData = await FacebookAuth.instance.getUserData();
//       _accessToken = accessToken;
//       setState(() {
//         _userData = userData;
//       });
//     } else {
//       _login();
//     }
//   }

//   _login() async {
//     final LoginResult loginResult = await FacebookAuth.instance.login();

//     if (loginResult.status == LoginStatus.success) {
//       _accessToken = loginResult.accessToken;
//       final userInfo = await FacebookAuth.instance.getUserData();
//       _userData = userInfo;
//     } else {
//       print('ResultStatus: ${loginResult.status}');
//       print('Message: ${loginResult.message}');
//     }
//   }

//   _logOut() async {
//     await FacebookAuth.instance.logOut();
//     _accessToken = null;
//     _userData = null;
//   }

//   @override
//   void initState() {
//     super.initState();
//     _ifUserIsLoggedIn();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: _checking!
//             ? const Center(
//                 child: CircularProgressIndicator(),
//               )
//             : Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const Text('Welcome'),
//                     _userData != null
//                         ? Text(
//                             '${_userData!['name']}',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 28),
//                           )
//                         : Container(),
//                     _userData != null
//                         ? Container(
//                             child: Text('working...'),
//                             // child: Image.network(
//                             //     _userData!\['picture'\]['data']['url']),
//                           )
//                         : Container(),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         _logOut();
//                         Navigator.pop(context);
//                       },
//                       child: const Text('Log Out'),
//                     ),
//                   ],
//                 ),
//               ));
//   }
// }
