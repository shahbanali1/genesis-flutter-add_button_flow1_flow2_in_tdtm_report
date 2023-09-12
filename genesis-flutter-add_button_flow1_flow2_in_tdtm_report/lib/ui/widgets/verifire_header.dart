import 'package:flutter/material.dart';
import 'package:management_app/constants/app_colors.dart';
import 'package:management_app/utils/data_streem.dart';

class VerifireHeader extends StatefulWidget {
  const VerifireHeader({Key? key}) : super(key: key);

  @override
  _VerifireHeader createState() => _VerifireHeader();
}

class _VerifireHeader extends State<VerifireHeader> {
  DateTime selectedDate = DateTime.now();
  List<bool> isSelected = [true, false];
  List<bool> isSelectedFlow = [true, false, false];
  String todayTomorrow = "0";
  String flowType = "0";

  @override
  void initState() {
    super.initState();
  }

  Color? getTextColor(bool isSelected) {
    if (isSelected) {
      return Colors.white;
    }

    return AppColors.primaryColor;
  }

  Color? getTextColorFlow(bool isSelectedFlow) {
    if (isSelectedFlow) {
      return Colors.white;
    }

    return AppColors.primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 8.0, top: 8.0, bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ToggleButtons(
                  selectedColor: AppColors.primaryColor,
                  fillColor: AppColors.primaryColor,
                  borderColor: AppColors.primaryColor,
                  borderWidth: 1,
                  renderBorder: true,
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Text(
                        "Tomorrow",
                        style: TextStyle(
                            color: getTextColor(todayTomorrow == "0")),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Text(
                        "Today",
                        style: TextStyle(
                          color: getTextColor(todayTomorrow == "1"),
                        ),
                      ),
                    ),
                  ],
                  onPressed: (int index) {
                    setState(() {
                      for (int indexBtn = 0;
                          indexBtn < isSelected.length;
                          indexBtn++) {
                        if (index == 0) {
                          todayTomorrow = "0";
                        } else {
                          todayTomorrow = "1";
                        }
                        if (indexBtn == index) {
                          isSelected[indexBtn] = !isSelected[indexBtn];
                        } else {
                          isSelected[indexBtn] = false;
                        }
                      }
                      DataStreem().controller.add({
                        "type": "verifier",
                        "value": {
                          "dayType": todayTomorrow,
                          "flowType": flowType
                        }
                      });
                    });
                  },
                  isSelected: isSelected,
                ),
                const Spacer(),
                ToggleButtons(
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
                        style:
                            TextStyle(color: getTextColorFlow(flowType == "0")),
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
                      DataStreem().controller.add({
                        "type": "verifier",
                        "value": {
                          "dayType": todayTomorrow,
                          "flowType": flowType
                        }
                      });
                    });
                  },
                  isSelected: isSelectedFlow,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
