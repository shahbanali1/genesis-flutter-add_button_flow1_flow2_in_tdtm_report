import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:management_app/constants/app_colors.dart';
import 'package:management_app/constants/screens.dart';
import 'package:management_app/utils/data_streem.dart';

class PerformanceOfTheDayHeader extends StatefulWidget {
  const PerformanceOfTheDayHeader({Key? key}) : super(key: key);

  @override
  _PerformanceOfTheDayHeaderState createState() =>
      _PerformanceOfTheDayHeaderState();
}

class _PerformanceOfTheDayHeaderState extends State<PerformanceOfTheDayHeader> {
  String selectedRole = 'Hotspot';
  String selectedLocation = 'Gurgoan';
  String selectedCount = '10';
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
                value: selectedRole,
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
                    selectedRole = newValue!;
                  });
                },
                items: <String>['Hotspot', 'Outbound', 'HM', 'Inbound']
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
                  value: selectedLocation,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  isExpanded: true,
                  underline: Container(
                    height: 1,
                    color: Colors.transparent,
                  ),
                  //elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedLocation = newValue!;
                    });
                  },
                  items: <String>['Gurgoan', 'Preetvihar']
                      .map<DropdownMenuItem<String>>((String value) {
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
                  value: selectedCount,
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
                      selectedCount = newValue!;
                    });
                  },
                  items: <String>['10', '20', '30', '40', '50']
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(primary: AppColors.primaryColor),
                // ignore: avoid_returning_null_for_void
                onPressed: () => DataStreem().controller.add({
                      "type": "performanceOfTheDay",
                      "value": {
                        "selectedRole": selectedRole,
                        "selectedLocation": selectedLocation,
                        "selectedCount": selectedCount,
                      }
                    }),
                child: const Text("GO")),
          ),
        ],
      ),
    );
  }
}
