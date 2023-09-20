import 'dart:async';

import 'package:flutter/material.dart';
import 'package:management_app/ui/screens/home_screen.dart';
import 'package:management_app/ui/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn = false;
  @override
  void initState() {
    super.initState();
    checkUserLoggedIn();
  }

  checkUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var loggedIn = prefs.getBool('isLoggedIn');
    isLoggedIn = loggedIn ?? false;
  }

  continueAppLoading() {
    Timer(
      const Duration(seconds: 1),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) =>
              isLoggedIn == false ? const LoginScreen() : HomeScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool lightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return Scaffold(
      backgroundColor: lightMode
          ? const Color(0x00e1f5fe).withOpacity(1.0)
          : const Color(0x00042a49).withOpacity(1.0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            lightMode
                ? Image.asset('assets/img_splash.png')
                : Image.asset('assets/img_splash.png'),
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                "MANAGEMENT APP",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   static Route route() {
//     return MaterialPageRoute<void>(builder: (_) => const LoginScreen());
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool lightMode =
//         MediaQuery.of(context).platformBrightness == Brightness.light;
//     return Scaffold(
//       backgroundColor: lightMode
//           ? const Color(0x00e1f5fe).withOpacity(1.0)
//           : const Color(0x00042a49).withOpacity(1.0),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             lightMode
//                 ? Image.asset('assets/img_splash.png')
//                 : Image.asset('assets/img_splash.png'),
//             const Padding(
//               padding: EdgeInsets.only(top: 20.0),
//               child: Text(
//                 "MANAGEMENT APP",
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
