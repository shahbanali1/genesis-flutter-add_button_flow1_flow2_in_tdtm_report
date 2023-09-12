import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:management_app/constants/app_colors.dart';
import 'package:management_app/ui/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ui/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var isloggedIn = prefs.getBool('isLoggedIn');
  runApp(GenesisApp(
    isLoggedIn: isloggedIn == null ? false : isloggedIn,
  ));
}

class GenesisApp extends StatelessWidget {
  final bool isLoggedIn;

  GenesisApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        fontFamily: GoogleFonts.kulimPark().fontFamily,
        textTheme: GoogleFonts.kulimParkTextTheme(),
      ),
      home: isLoggedIn == false ? const LoginScreen() : const HomeScreen(),
      //home: const HomeScreen(),
    );
  }
}
