import 'package:flutter/material.dart';
import 'package:management_app/constants/screens.dart';
import 'package:management_app/utils/common_utils.dart';
import 'package:management_app/utils/data_streem.dart';

class DispositionHeader extends StatefulWidget {
  const DispositionHeader({Key? key}) : super(key: key);

  @override
  _DispositionHeaderState createState() => _DispositionHeaderState();
}

class _DispositionHeaderState extends State<DispositionHeader> {
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();
  CommonUtils commonUtils = CommonUtils();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon: const Icon(Icons.date_range_outlined,
                size: 30, color: Colors.blue),
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
                    border: Border.all(color: Colors.blue),
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
                  size: 30, color: Colors.blue),
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
                    border: Border.all(color: Colors.blue),
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
        "type": Screens.dispositionReport,
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
      lastDate: DateTime(2030),
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
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedToDate) {
      setState(() {
        selectedToDate = picked;
      });
    }
  }
}
