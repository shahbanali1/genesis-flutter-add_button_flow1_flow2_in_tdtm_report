import 'package:flutter/material.dart';
import 'package:management_app/constants/app_colors.dart';
import 'package:management_app/constants/screens.dart';
import 'package:management_app/utils/data_streem.dart';

class PhleboAttendancePickupHeader extends StatefulWidget {
  final List<String> rmList;
  final String selectedRM;
  const PhleboAttendancePickupHeader(
      {Key? key, required this.rmList, required this.selectedRM})
      : super(key: key);

  @override
  _PhleboAttendancePickupHeaderState createState() =>
      _PhleboAttendancePickupHeaderState();
}

class _PhleboAttendancePickupHeaderState
    extends State<PhleboAttendancePickupHeader> {
  String selectedRM = "All";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, top: 8.0, bottom: 8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: DropdownButton<String>(
                      value: selectedRM,
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
                          selectedRM = newValue!;
                        });
                      },
                      items: widget.rmList
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
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: AppColors.primaryColor),
                    onPressed: () => DataStreem().controller.add({
                          "type": Screens.phleboAttendancePickup,
                          "value": {
                            "selectedRM": selectedRM,
                          }
                        }),
                    child: const Text("GO")),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
