import 'package:flutter/material.dart';
import 'package:management_app/models/rm_attendance_model.dart';

class RmAttendanceDataTableWidget extends StatefulWidget {
  final List<RMAttendanceModel> reportData;
  const RmAttendanceDataTableWidget({Key? key, required this.reportData})
      : super(key: key);

  @override
  State<RmAttendanceDataTableWidget> createState() =>
      _RmAttendanceDataTableWidgetState();
}

class _RmAttendanceDataTableWidgetState
    extends State<RmAttendanceDataTableWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
