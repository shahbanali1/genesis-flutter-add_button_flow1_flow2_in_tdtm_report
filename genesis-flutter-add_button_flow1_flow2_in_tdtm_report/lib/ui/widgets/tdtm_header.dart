import 'package:flutter/material.dart';
import 'package:management_app/constants/app_colors.dart';
import 'package:management_app/utils/common_utils.dart';
import 'package:management_app/utils/data_streem.dart';

class TDTMHeader extends StatefulWidget {
  const TDTMHeader({Key? key}) : super(key: key);

  @override
  _TDTMHeaderState createState() => _TDTMHeaderState();
}

class _TDTMHeaderState extends State<TDTMHeader> {
  DateTime now = DateTime.now();
  late DateTime selectedFromDate; // = new DateTime(now.year, now.month + 1, 0);
  DateTime selectedToDate = DateTime.now();
  CommonUtils commonUtils = CommonUtils();

  Color? getTextColorFlow(bool isSelectedFlow) {
    if (isSelectedFlow) {
      return Colors.white;
    }

    return AppColors.primaryColor;
  }

  List<bool> isSelectedFlow = [true, false, false];
  String flowType = "0";

  @override
  void initState() {
    super.initState();
    selectedFromDate = new DateTime(now.year, now.month, 1);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
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
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
            child: ToggleButtons(
              selectedColor: AppColors.primaryColor,
              fillColor: AppColors.primaryColor,
              borderColor: AppColors.primaryColor,
              borderWidth: 1,
              renderBorder: true,
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                  child: Text(
                    "T",
                    style: TextStyle(color: getTextColorFlow(flowType == "0")),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                  child: Text(
                    "F1",
                    style: TextStyle(
                      color: getTextColorFlow(flowType == "1"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                  child: Text(
                    "F2",
                    style: TextStyle(
                      color: getTextColorFlow(flowType == "2"),
                    ),
                  ),
                ),
              ],
              onPressed: (int index) {
                setState(() {
                  for (int indexBtn = 0;
                      indexBtn < isSelectedFlow.length;
                      indexBtn++) {
                    if (index == 0) {
                      flowType = "0";
                    }
                    if (index == 1) {
                      flowType = "1";
                    }
                    if (index == 2) {
                      flowType = "2";
                    }

                    if (indexBtn == index) {
                      isSelectedFlow[indexBtn] = !isSelectedFlow[indexBtn];
                    } else {
                      isSelectedFlow[indexBtn] = false;
                    }
                  }
                });
                dateValidation(selectedFromDate, selectedToDate);
              },
              isSelected: isSelectedFlow,
            ),
          ),
        ],
      ),
    );
  }

  dateValidation(DateTime fromDate, DateTime ToDate) {
    if (fromDate.month == ToDate.month) {
      DataStreem().controller.add({
        "type": "tdtmReport",
        "value": {
          "selectedFromDate": "${selectedFromDate.toLocal()}".split(' ')[0],
          "selectedToDate": "${selectedToDate.toLocal()}".split(' ')[0],
          "fromDate2": getSubstractedMonthDate(selectedFromDate, 1),
          "toDate2": getSubstractedMonthDate(selectedToDate, 1),
          "fromDate3": getSubstractedMonthDate(selectedFromDate, 2),
          "toDate3": getSubstractedMonthDate(selectedToDate, 2),
          "fromDate4": getSubstractedMonthDate(selectedFromDate, 3),
          "toDate4": getSubstractedMonthDate(selectedToDate, 3),
          "flow2": flowType,
        }
      });
    } else {
      commonUtils.showSnackBar(
          context, "From date and to date should be from same month");
    }
  }

  String getSubstractedMonthDate(DateTime now, int monthsToSubstract) {
    DateTime substracted =
        DateTime(now.year, now.month - monthsToSubstract, now.day);
    return "${substracted.toLocal()}".split(' ')[0];
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
