import 'package:flutter/material.dart';
import 'package:management_app/constants/app_colors.dart';
import 'package:management_app/models/item_model.dart';
import 'package:management_app/utils/common_utils.dart';
import 'package:management_app/utils/management_apis.dart';

class MasterPinScreen extends StatefulWidget {
  const MasterPinScreen({Key? key}) : super(key: key);

  @override
  State<MasterPinScreen> createState() => _MasterPinScreenState();
}

class _MasterPinScreenState extends State<MasterPinScreen> {
  String currentPin = "";
  TextEditingController newPinController = TextEditingController();
  late Future<ItemModel> masterPinFuture;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Master Pin"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<ItemModel>(
              future: ManagementApis()
                  .getCurrentUserPin(CommonUtils().checkPlatformType()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                      snapshot.data!.pin == "-&&-"
                          ? "No pin created yet"
                          : "Current Pin: ${getPin(snapshot.data!.pin!)}",
                      style: TextStyle(fontSize: 18));
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Enter new pin",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter new pin",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              controller: newPinController,
              keyboardType: TextInputType.number,
              maxLength: 6,
            ),
            SizedBox(
              height: 16,
            ),
            Center(
                child: SizedBox(
                    height: 50,
                    width: 160,
                    child: ElevatedButton(
                        onPressed: () {
                          if (newPinController.text.length < 6) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Pin must be 6 digits")));
                            return;
                          }
                          ManagementApis()
                              .createNewUserPin("1", newPinController.text,
                                  CommonUtils().checkPlatformType())
                              .then((value) {
                            if (value.pin == "1") {
                              // CommonUtils().showAlertDialog(
                              //   context,
                              //   "Master Pin Created Successfully: ${newPinController.text}",
                              // );
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "Master Pin Created Successfully: ${newPinController.text}")));
                              newPinController.clear();
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "Unable to create pin please try again")));
                            }
                          });
                        },
                        child: Text("Create Pin"))))
          ],
        ),
      ),
    );
  }

  String getPin(String pin) {
    List<String> parts =
        pin.split('&'); // Split the string at the '&' character
    String resultString = parts[0];
    return resultString;
  }
}
