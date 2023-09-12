import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:management_app/constants/app_colors.dart';
import 'package:management_app/utils/common_utils.dart';
import 'package:management_app/utils/data_streem.dart';

class InboundHeader extends StatefulWidget {
  const InboundHeader({Key? key}) : super(key: key);

  @override
  _InboundHeaderState createState() => _InboundHeaderState();
}

class _InboundHeaderState extends State<InboundHeader> {
  String selectedMonth = CommonUtils.getCurrentMonth();
  String selectedTimeSlot = '09:00-10:00';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: DropdownButton<String>(
                value: selectedMonth,
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
                    selectedMonth = newValue!;
                  });
                },
                items: <String>[
                  'January',
                  'February',
                  'March',
                  'April',
                  'May',
                  'June',
                  'July',
                  'August',
                  'September',
                  'October',
                  'November',
                  'December'
                ].map<DropdownMenuItem<String>>((String value) {
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
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                child: DropdownButton<String>(
                  value: selectedTimeSlot,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  isExpanded: true,
                  elevation: 8,
                  underline: Container(
                    height: 1,
                    color: Colors.transparent,
                  ),
                  style: const TextStyle(color: Colors.black),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedTimeSlot = newValue!;
                    });
                  },
                  items: <String>[
                    '09:00-10:00',
                    '10:00-11:00',
                    '11:00-12:00',
                    '12:00-13:00',
                    '13:00-14:00',
                    '14:00-15:00',
                    '15:00-16:00',
                    '16:00-17:00',
                    '17:00-18:00',
                    '18:00-19:00',
                    '19:00-20:00',
                    '20:00-21:00',
                    '21:00-22:00',
                    '22:00-23:00',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Center(
                          child: Text(
                        value,
                        overflow: TextOverflow.ellipsis,
                      )),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(primary: AppColors.primaryColor),
                // ignore: avoid_returning_null_for_void
                onPressed: () => DataStreem().controller.add({
                      "type": "inbound",
                      "value": {
                        "selectedMonth": selectedMonth,
                        "selectedTimeSlot": selectedTimeSlot
                      }
                    }),
                child: const Text("GO")),
          ),
        ],
      ),
    );
  }
}
