import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:management_app/constants/app_colors.dart';
import 'package:management_app/constants/string.dart';
import 'package:management_app/models/item_model.dart';
import 'package:management_app/models/otp_verify_model.dart';
import 'package:management_app/ui/screens/home_screen.dart';
import 'package:management_app/utils/common_utils.dart';
import 'package:management_app/utils/management_apis.dart';
import 'package:management_app/utils/shared_prefs.dart';

class OtpScreen extends StatefulWidget {
  final String mobileNo;
  const OtpScreen({Key? key, required this.mobileNo}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const HomeScreen());
  }

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  void initState() {
    super.initState();
    print("mobileNo" + widget.mobileNo);
  }

  ManagementApis managementApis = ManagementApis();
  final otpController = TextEditingController();
  CommonUtils commonUtils = CommonUtils();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              assetImage(),
              const SizedBox(height: 10.0),
              title(),
              const SizedBox(height: 15.0),
              otpField(),
              const SizedBox(height: 15.0),
              submitOTPButton(managementApis),
              const SizedBox(height: 15.0),
              subTitleNew(),
            ],
          ),
        ),
      ),
    );
  }

  Widget assetImage() {
    return Container(
      width: 256,
      height: 256,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Image.asset("assets/logo_small.png"),
    );
  }

  Widget title() {
    return Column(
      children: const [
        Text(
          "Enter the OTP recieved",
          style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 15),
        ),
      ],
    );
  }

  Widget subTitleNew() {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            style: const TextStyle(fontSize: 15.0, color: Colors.grey),
            children: [
              const TextSpan(text: "Haven't recived the code?"),
              TextSpan(
                  text: ' RESEND',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      loginAPICall();
                    },
                  style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold)),
            ]));
  }

  Future<ItemModel> loginAPICall() async {
    String? validDeviceId = await CommonUtils.getId();
    return managementApis.loginAPIRequest(
        widget.mobileNo, validDeviceId, commonUtils.checkPlatformType());
  }

  Widget otpField() {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
      child: SizedBox(
        width: double.infinity,
        child: TextField(
          style: const TextStyle(fontSize: 18.0, color: Colors.black),
          textAlign: TextAlign.center,
          controller: otpController,
          keyboardType: TextInputType.phone,
          maxLength: 6,
          decoration: const InputDecoration(
            hintText: 'OTP',
            errorText: null,
            counterText: "",
          ),
        ),
      ),
    );
  }

  Widget submitOTPButton(ManagementApis managementApis) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: AppColors.primaryColor),
          child: const Text(
            Strings.otpBtnText,
            style: TextStyle(fontSize: 17.0, color: Colors.white),
          ),
          onPressed: () {
            validateOTP(otpController.text);
          },
        ),
      ),
    );
  }

  validateOTP(String otp) {
    if (otp.length == 6) {
      commonUtils.showLoaderDialog(context, "Please wait...");
      callOTPVerifyAPI().then((response) {
        Navigator.pop(context);
        if (response.runnerID!.isNotEmpty) {
          SharedPrefs sharedPrefs = SharedPrefs();
          sharedPrefs.updateUserLoggedIn();
          sharedPrefs.setUserId(response.runnerID.toString());
          sharedPrefs.setAppCode(response.appCode.toString());
          sharedPrefs.setJobRole(response.jobRole.toString());

          Navigator.of(context).push(OtpScreen.route());
        } else {
          var snackBar =
              const SnackBar(content: Text("Please enter valid OTP"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    } else {
      var snackBar = const SnackBar(content: Text("Please enter valid OTP"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<OTPVerifyModel> callOTPVerifyAPI() async {
    String? validDeviceId = await CommonUtils.getId();
    return managementApis.otpVerifyAPIRequest(widget.mobileNo,
        otpController.text, validDeviceId, commonUtils.checkPlatformType());
  }
}
