import 'package:flutter/material.dart';
import 'package:management_app/constants/app_colors.dart';
import 'package:management_app/utils/common_utils.dart';
import 'package:management_app/utils/data_streem.dart';

class HotSpotZoneWiseHeader extends StatefulWidget {
  const HotSpotZoneWiseHeader({Key? key}) : super(key: key);

  @override
  _HotSpotZoneWiseHeaderState createState() => _HotSpotZoneWiseHeaderState();
}

class _HotSpotZoneWiseHeaderState extends State<HotSpotZoneWiseHeader> {
  DateTime selectedDate = DateTime.now();
  CommonUtils commonUtils = CommonUtils();
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
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(primary: AppColors.primaryColor),
                // ignore: avoid_returning_null_for_void
                onPressed: () => DataStreem().controller.add({
                      "type": "hotspotZoneWise",
                      "value": {
                        "selectedDate":
                            "${selectedDate.toLocal()}".split(' ')[0]
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
