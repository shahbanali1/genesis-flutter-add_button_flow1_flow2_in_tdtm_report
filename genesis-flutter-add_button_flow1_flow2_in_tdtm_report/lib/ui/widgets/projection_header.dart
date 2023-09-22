import 'package:flutter/material.dart';
import 'package:management_app/constants/app_colors.dart';
import 'package:management_app/constants/screens.dart';
import 'package:management_app/utils/common_utils.dart';
import 'package:management_app/utils/data_streem.dart';

class ProjectionHeader extends StatefulWidget {
  const ProjectionHeader({Key? key}) : super(key: key);

  @override
  _ProjectionHeaderState createState() => _ProjectionHeaderState();
}

class _ProjectionHeaderState extends State<ProjectionHeader> {
  DateTime selectedFromDate =
      DateTime.now(); // = new DateTime(now.year, now.month + 1, 0);
  DateTime selectedToDate = DateTime.now();
  CommonUtils commonUtils = CommonUtils();
  bool isZeroValuePackage = true;
  TextEditingController _workingDayController = TextEditingController();
  TextEditingController _monthlyWorkingDayController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CheckboxListTile(
            activeColor: AppColors.primaryColor,
            selectedTileColor: AppColors.primaryColor,
            fillColor: MaterialStateColor.resolveWith(
                (states) => AppColors.primaryColor),
            title: Text('Zero Value Package'),
            value: isZeroValuePackage, // Set the initial value of the checkbox
            onChanged: (bool? value) {
              setState(() {
                isZeroValuePackage = value!;
              });
              // Handle checkbox value changes
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.date_range_outlined,
                    size: 30, color: AppColors.primaryColor),
                onPressed: () {
                  showFromDateDialog(context);
                },
              ),
              GestureDetector(
                  onTap: () {
                    showFromDateDialog(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primaryColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${selectedFromDate.toLocal()}".split(' ')[0],
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: IconButton(
                  icon: const Icon(Icons.date_range_outlined,
                      size: 30, color: AppColors.primaryColor),
                  onPressed: () {
                    showToDateDialog(context);
                  },
                ),
              ),
              GestureDetector(
                  onTap: () {
                    showToDateDialog(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primaryColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${selectedToDate.toLocal()}".split(' ')[0],
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor),
                    onPressed: () {
                      dateValidation(selectedFromDate, selectedToDate);
                    },
                    child: const Text("GO")),
              ),
            ],
          ),
          SizedBox(
            height: 0,
          ),
          Visibility(
            visible: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(),
                        ),
                        hintText: 'Working Day',
                        hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                        isDense: true,
                        contentPadding: EdgeInsets.all(8),
                      ),
                      controller: _workingDayController,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 1,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(),
                        ),
                        hintText: 'Monthly Working Day',
                        hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                        isDense: true,
                        contentPadding: EdgeInsets.all(8),
                      ),
                      controller: _monthlyWorkingDayController,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  dateValidation(DateTime fromDate, DateTime ToDate) {
    if (fromDate.month == ToDate.month) {
      DataStreem().controller.add({
        "type": Screens.projectionReport,
        "value": {
          "selectedFromDate": "${selectedFromDate.toLocal()}".split(' ')[0],
          "selectedToDate": "${selectedToDate.toLocal()}".split(' ')[0],
          "isZeroValuePackage": isZeroValuePackage ? "1" : "0",
        }
      });
    } else {
      commonUtils.showSnackBar(
          context, "From date and to date should be from same month");
    }
  }

  showFromDateDialog(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedFromDate, // Refer step 1
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedFromDate) {
      setState(() {
        selectedFromDate = picked;
      });
    }
  }

  showToDateDialog(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedToDate, // Refer step 1
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedToDate) {
      setState(() {
        selectedToDate = picked;
      });
    }
  }
}
