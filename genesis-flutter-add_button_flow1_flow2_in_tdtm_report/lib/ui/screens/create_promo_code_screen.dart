import 'package:flutter/material.dart';
import 'package:management_app/constants/app_colors.dart';
import 'package:management_app/models/package_test_type_model.dart';
import 'package:management_app/utils/common_utils.dart';

class CreatePromoCodeScreen extends StatefulWidget {
  const CreatePromoCodeScreen({Key? key}) : super(key: key);

  @override
  State<CreatePromoCodeScreen> createState() => _CreatePromoCodeScreenState();
}

class _CreatePromoCodeScreenState extends State<CreatePromoCodeScreen> {
  String selectedPercentage = "1";
  PackageTestTypeModel selectedTestType = CommonUtils().getTestType()[0];
  String selectedMax = "1";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Center(child: Text("Create Promo Code")),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Percentage:", style: TextStyle(fontSize: 18)),
                Container(
                  width: 150,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: DropdownButton<String>(
                    value: selectedPercentage,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 8,
                    isExpanded: true,
                    underline: Container(
                      height: 1,
                      color: Colors.transparent,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedPercentage = newValue!;
                      });
                    },
                    items: CommonUtils()
                        .getPersentageList()
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Center(
                          child: Text(
                            value,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Type:", style: TextStyle(fontSize: 18)),
                Container(
                  width: 150,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: DropdownButton<PackageTestTypeModel>(
                    value: selectedTestType,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 8,
                    isExpanded: true,
                    underline: Container(
                      height: 1,
                      color: Colors.transparent,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    onChanged: (PackageTestTypeModel? newValue) {
                      setState(() {
                        selectedTestType = newValue!;
                      });
                    },
                    items: CommonUtils()
                        .getTestType()
                        .map<DropdownMenuItem<PackageTestTypeModel>>(
                            (PackageTestTypeModel value) {
                      return DropdownMenuItem<PackageTestTypeModel>(
                        value: value,
                        child: Center(
                          child: Text(
                            value.testTypeShow,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Max:", style: TextStyle(fontSize: 18)),
                Container(
                  width: 150,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: DropdownButton<String>(
                    value: selectedMax,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 8,
                    isExpanded: true,
                    underline: Container(
                      height: 1,
                      color: Colors.transparent,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedMax = newValue!;
                      });
                    },
                    items: CommonUtils()
                        .getMaxList()
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Center(
                          child: Text(
                            value,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
