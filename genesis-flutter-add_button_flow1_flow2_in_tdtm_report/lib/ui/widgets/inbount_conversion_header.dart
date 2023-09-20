import 'package:flutter/material.dart';
import 'package:management_app/constants/app_colors.dart';
import 'package:management_app/constants/screens.dart';
import 'package:management_app/utils/data_streem.dart';

class InboundConversionHeader extends StatefulWidget {
  const InboundConversionHeader({Key? key}) : super(key: key);

  @override
  State<InboundConversionHeader> createState() =>
      _InboundConversionHeaderState();
}

class _InboundConversionHeaderState extends State<InboundConversionHeader> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Row(
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
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor),
              // ignore: avoid_returning_null_for_void
              onPressed: () => DataStreem().controller.add({
                    "type": Screens.inboundConversionReport,
                    "value": {
                      "selectedDate": "${selectedDate.toLocal()}".split(' ')[0],
                    }
                  }),
              child: const Text("GO")),
        ),
      ],
    );
  }

  showDateDialog(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
