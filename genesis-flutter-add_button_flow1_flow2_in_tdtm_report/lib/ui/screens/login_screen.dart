import 'package:flutter/material.dart';
import 'package:management_app/constants/app_colors.dart';
import 'package:management_app/models/item_model.dart';
import 'package:management_app/ui/screens/otp_screen.dart';
import 'package:management_app/utils/common_utils.dart';
import 'package:management_app/utils/management_apis.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static Route route(String mobileNumber) {
    return MaterialPageRoute<void>(
        builder: (_) => OtpScreen(
              mobileNo: mobileNumber,
            ));
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ManagementApis managementApis = ManagementApis();
  final mobileController = TextEditingController();
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
              const SizedBox(height: 20.0),
              mobileField(),
              const SizedBox(height: 8.0),
              subTitle(),
              const SizedBox(height: 15.0),
              submitButton(),
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

  Widget mobileNoText() {
    return const Padding(
      padding: EdgeInsets.only(top: 30.0),
      child: Text(
        "Enter Mobile Number",
        style: TextStyle(
            color: Color(0xff9E9E9E),
            fontWeight: FontWeight.bold,
            fontSize: 15),
      ),
    );
  }

  Widget subTitle() {
    return const Text(
      "An OTP will be sent to this number for verification",
      style: TextStyle(
          color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 12),
    );
  }

  Widget mobileField() {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
      child: SizedBox(
        width: double.infinity,
        child: TextField(
          style: const TextStyle(fontSize: 18.0, color: Colors.black),
          textAlign: TextAlign.center,
          controller: mobileController,
          maxLength: 10,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            hintText: 'Enter mobile numer',
            errorText: null,
            counterText: "",
          ),
        ),
      ),
    );
  }

  Widget submitButton() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: AppColors.primaryColor),
            child: const Text(
              'Get OTP',
              style: TextStyle(fontSize: 17.0, color: Colors.white),
            ),
            onPressed: () {
              validateMobile(mobileController.text);
            }),
      ),
    );
  }

  validateMobile(String mobileNo) {
    if (mobileNo.length == 10) {
      commonUtils.showLoaderDialog(context, "Please wait...");
      loginAPICall().then((response) {
        if (response.otp == "Invalid User ID") {
          Navigator.pop(context);
          var snackBar =
              const SnackBar(content: Text("Please enter a valid mobile no"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          Navigator.pop(context);
          Navigator.of(context).push(LoginScreen.route(mobileController.text));
        }
      });
    } else {
      var snackBar =
          const SnackBar(content: Text("Please enter a valid mobile no"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<ItemModel> loginAPICall() async {
    String? validDeviceId = await CommonUtils.getId();
    return managementApis.loginAPIRequest(
        mobileController.text, validDeviceId, commonUtils.checkPlatformType());
  }
}
