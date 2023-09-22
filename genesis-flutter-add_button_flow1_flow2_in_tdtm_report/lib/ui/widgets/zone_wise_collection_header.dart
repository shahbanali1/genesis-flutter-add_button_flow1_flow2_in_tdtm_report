import 'package:flutter/material.dart';
import 'package:management_app/constants/app_colors.dart';
import 'package:management_app/constants/screens.dart';
import 'package:management_app/utils/data_streem.dart';

class ZoneWiseCollectionHeader extends StatefulWidget {
  const ZoneWiseCollectionHeader({Key? key}) : super(key: key);

  @override
  State<ZoneWiseCollectionHeader> createState() =>
      _ZoneWiseCollectionHeaderState();
}

class _ZoneWiseCollectionHeaderState extends State<ZoneWiseCollectionHeader> {
  DateTime selectedDate = DateTime.now();
  String selectedTimeSlot = '15:00-16:00';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
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
                width: 120,
                height: 38,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryColor),
                    borderRadius: const BorderRadius.all(Radius.circular(5.0))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${selectedDate.toLocal()}".split(' ')[0],
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
                      "type": Screens.zoneWiseCollectionReport,
                      "value": {
                        "selectedDate":
                            "${selectedDate.toLocal()}".split(' ')[0],
                        "selectedTimeSlot": selectedTimeSlot
                      }
                    }),
                child: const Text("GO")),
          ),
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
