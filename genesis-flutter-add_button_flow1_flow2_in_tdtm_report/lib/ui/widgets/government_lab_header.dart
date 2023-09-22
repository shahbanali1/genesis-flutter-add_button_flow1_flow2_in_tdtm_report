import 'package:flutter/material.dart';
import 'package:management_app/constants/app_colors.dart';
import 'package:management_app/utils/common_utils.dart';
import 'package:management_app/utils/data_streem.dart';

class GovernmentLabHeader extends StatefulWidget {
  const GovernmentLabHeader({Key? key}) : super(key: key);

  @override
  _GovernmentLabHeaderState createState() => _GovernmentLabHeaderState();
}

class _GovernmentLabHeaderState extends State<GovernmentLabHeader> {
  DateTime selectedFromDate = DateTime.now().subtract(Duration(days: 1));
  DateTime selectedToDate = DateTime.now();
  CommonUtils commonUtils = CommonUtils();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          icon: const Icon(Icons.date_range_outlined,
              size: 30, color: AppColors.primaryColor),
          onPressed: () {
            showDateDialog(context);
          },
        ),
        GestureDetector(
            onTap: () {
              showDateDialog(context);
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primaryColor),
                  borderRadius: const BorderRadius.all(Radius.circular(5.0))),
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
                  borderRadius: const BorderRadius.all(Radius.circular(5.0))),
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
              style: ElevatedButton.styleFrom(primary: AppColors.primaryColor),
              onPressed: () => dateValidation(selectedFromDate, selectedToDate),
              child: const Text("GO")),
        ),
      ],
    );
  }

  dateValidation(DateTime fromDate, DateTime toDate) {
    if (fromDate.month == toDate.month && fromDate.year == toDate.year) {
      DataStreem().controller.add({
        "type": "governmentLabReport",
        "value": {
          "selectedFromDate": "${selectedFromDate.toLocal()}".split(' ')[0],
          "selectedToDate": "${selectedToDate.toLocal()}".split(' ')[0]
        }
      });
    } else {
      commonUtils.showSnackBar(context, "Please select same month and year");
    }
  }

  showDateDialog(BuildContext context) async {
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
