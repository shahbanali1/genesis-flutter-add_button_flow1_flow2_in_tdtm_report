import 'package:flutter/material.dart';
import 'package:management_app/constants/app_colors.dart';
import 'package:management_app/utils/common_utils.dart';
import 'package:management_app/utils/data_streem.dart';

class TeamWiseRevenueHeader extends StatefulWidget {
  const TeamWiseRevenueHeader({Key? key}) : super(key: key);

  @override
  _TeamWiseRevenueHeaderState createState() => _TeamWiseRevenueHeaderState();
}

class _TeamWiseRevenueHeaderState extends State<TeamWiseRevenueHeader> {
  DateTime now = DateTime.now();
  late DateTime selectedFromDate; // = new DateTime(now.year, now.month + 1, 0);
  DateTime selectedToDate = DateTime.now();
  CommonUtils commonUtils = CommonUtils();

  @override
  void initState() {
    super.initState();
    selectedFromDate = new DateTime(now.year, now.month, 1);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
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
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor),
                onPressed: () {
                  dateValidation(selectedFromDate, selectedToDate);
                },
                child: const Text("GO")),
          ),
        ],
      ),
    );
  }

  dateValidation(DateTime fromDate, DateTime ToDate) {
    if (fromDate.month == ToDate.month) {
      DataStreem().controller.add({
        "type": "teamWiseRevenue",
        "value": {
          "selectedFromDate": "${selectedFromDate.toLocal()}".split(' ')[0],
          "selectedToDate": "${selectedToDate.toLocal()}".split(' ')[0],
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
