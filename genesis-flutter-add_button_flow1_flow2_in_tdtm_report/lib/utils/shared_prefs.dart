import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static final SharedPrefs _singleton = SharedPrefs._internal();

  factory SharedPrefs() {
    return _singleton;
  }

  SharedPrefs._internal();

  void setLoggedIn(bool status) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (status) {
      _prefs.setBool('isLoggedIn', true);
    } else {
      _prefs.setBool('isLoggedIn', false);
    }
  }

  Future<bool?> isLoggedIn() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool('isLoggedIn');
  }

  void setUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user_id", userId);
  }

  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringValue = prefs.getString("user_id");
    return stringValue;
  }

  void setJobRole(String jobrole) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("jobRole", jobrole);
  }

  getJobRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringValue = prefs.getString("jobRole");
    return stringValue;
  }

  void setAppCode(String appCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("appCode", appCode);
  }

  getAppCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringValue = prefs.getString("appCode");
    return stringValue;
  }

  void setUserMobileNumber(String mobileNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("mobileNumber", mobileNumber);
  }

  getUserMobileNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringValue = prefs.getString("mobileNumber");
    return stringValue;
  }

  // bool isLoggedIn() async {
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   var isLoggedIn = _prefs.getBool('isLoggedIn');
  //   return true;
  // }
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // var isloggedIn = prefs.getBool('isLoggedIn');
}
