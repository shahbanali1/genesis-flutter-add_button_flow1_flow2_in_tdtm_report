import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:management_app/constants/app_colors.dart';
import 'package:management_app/utils/common_utils.dart';
import 'package:management_app/utils/data_streem.dart';

class AgentPickupHeader extends StatefulWidget {
  const AgentPickupHeader({Key? key}) : super(key: key);

  @override
  _AgentPickupHeaderState createState() => _AgentPickupHeaderState();
}

class _AgentPickupHeaderState extends State<AgentPickupHeader> {
  DateTime selectedDate = DateTime.now();
  String userRole = 'Hotspot';
  String location = 'Gurgoan';
  CommonUtils commonUtils = CommonUtils();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, top: 8.0, bottom: 8.0),
      child: Column(
        children: [
          Row(
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
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primaryColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Center(
                        child: Text(
                          "${selectedDate.toLocal()}".split(' ')[0],
                        ),
                      ),
                    ),
                  )),
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
                      value: userRole,
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
                          userRole = newValue!;
                        });
                      },
                      items: <String>[
                        'Hotspot',
                        'OB',
                        'HM',
                        'Inbound',
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
              ),
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
                      value: location,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      isExpanded: true,
                      //elevation: 16,
                      underline: Container(
                        height: 1,
                        color: Colors.transparent,
                      ),
                      style: const TextStyle(color: Colors.black),
                      onChanged: (String? newValue) {
                        setState(() {
                          location = newValue!;
                        });
                      },
                      items: <String>[
                        'Gurgoan',
                        'Preet Vihar',
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
                    // ignore: avoid_returning_null_for_void
                    style: ElevatedButton.styleFrom(
                        primary: AppColors.primaryColor),
                    onPressed: () => DataStreem().controller.add({
                          "type": "agentPickup",
                          "value": {
                            "selectedDate":
                                "${selectedDate.toLocal()}".split(' ')[0],
                            "userRole": userRole,
                            "location": location
                          }
                        }),
                    child: const Text("GO")),
              ),
            ],
          )
        ],
      ),
    );
  }

  showDateDialog(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
