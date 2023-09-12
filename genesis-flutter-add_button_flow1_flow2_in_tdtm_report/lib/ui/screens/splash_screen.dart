import 'package:flutter/material.dart';
import 'package:management_app/ui/screens/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginScreen());
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
