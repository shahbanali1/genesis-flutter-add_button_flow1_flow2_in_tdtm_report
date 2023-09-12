import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  void updateUserLoggedIn() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool('isLoggedIn', true);
  }

  // bool isLoggedIn() async {
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   var isLoggedIn = _prefs.getBool('isLoggedIn');
  //   return true;
  // }
  //SharedPreferences prefs = await SharedPreferences.getInstance();
  //var isloggedIn = prefs.getBool('isLoggedIn');
}
