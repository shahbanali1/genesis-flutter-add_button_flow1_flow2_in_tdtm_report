import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:management_app/constants/app_colors.dart';
import 'package:management_app/models/base_model.dart';
import 'package:management_app/models/rm_attendance_model.dart';

class RmAttendanceDataTableWidget extends StatefulWidget {
  final List<BaseModel> reportData;
  const RmAttendanceDataTableWidget({
    Key? key,
    required this.reportData,
  }) : super(key: key);

  @override
  State<RmAttendanceDataTableWidget> createState() =>
      _RmAttendanceDataTableWidgetState();
}

class _RmAttendanceDataTableWidgetState
    extends State<RmAttendanceDataTableWidget> {
  List<DataColumn> getTableHeaders(List<RMAttendanceModel>? model) {
    List<DataColumn> columns = [];

    // var rawData = model.toJson();
    bool shouldAddDate = true;
    for (var name in model!) {
      var rawData = name.toJson();
      for (var key in rawData.keys) {
        if (key == "logindate" && shouldAddDate) {
          columns.add(DataColumn(
            numeric: isNumeric("Date"),
            label: Center(
              child: Text(
                fixHeaderText("Date"),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
          ));
          shouldAddDate = false;
        }
        if (key == "RMName") {
          String headerName = rawData[key].toString();
          bool columnExists = columns.any((column) =>
              column.label is Center &&
              (column.label as Center).child is Text &&
              ((column.label as Center).child as Text).data == headerName);
          if (!columnExists) {
            columns.add(DataColumn(
              numeric: isNumeric(headerName),
              label: Center(
                child: Text(
                  fixHeaderText(headerName),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ),
            ));
          }
        }
      }
    }

    return columns;
  }

  String fixHeaderText(String s) {
    s = s.replaceAll("amount", " ₹");
    s = s.replaceAll("Amount", " ₹");

    s = s.replaceAll("count", " #");
    s = s.replaceAll("Count", " #");
    return s;
  }

//Prepair table rows
  List<DataRow> getTableRows(List<RMAttendanceModel>? data) {
    List<DataRow> rows = [];
    Set<String> addedDates = {};

    var i = 0;

    for (var d in data!) {
      var rawData = d.toJson();
      for (var key in rawData.keys) {
        // if (key == "logindate") {
        //   String date = d.logindate.toString();
        //   if (!addedDates.contains(date)) {
        //     rows.add(
        //         DataRow(cells: getCells(d), color: getRowColor(rows.length)));
        //     addedDates.add(date);
        //   }
        // }
        // if (key == "logintime") {
        //   rows.add(DataRow(cells: getCells(d), color: getRowColor(i)));
        // }
        i++;
      }
      //rows.add(DataRow(cells: getCells(d), color: getRowColor(i)));
    }

    return rows;
  }

  MaterialStateProperty<Color> getRowColor(var index) {
    var color = Colors.white;
    if (index % 2 == 0) {
      color = Colors.grey.shade100;
    }

    return MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
      return color;
    });
  }

//Prepair row cells
  List<DataCell> getCells(RMAttendanceModel model) {
    return List<DataCell>.from(
        model.toJson().values.map((e) => DataCell(Container(
              width: double.infinity,
              child: Text(
                cellText(e.toString()),
                textAlign: getTextAlignment(e.toString()),
                style: const TextStyle(
                  fontSize: 10,
                ),
              ),
            ))));
    // List<DataCell> cellList = [];
    // cellList.add(DataCell(Container(
    //   width: double.infinity,
    //   child: Text(
    //     splitStringFromSpace(model.logindate.toString()),
    //     textAlign: getTextAlignment(model.logindate.toString()),
    //     style: const TextStyle(
    //       fontSize: 10,
    //     ),
    //   ),
    // )));
    // cellList.add(DataCell(Container(
    //   width: double.infinity,
    //   child: Text(
    //     splitStringFromComma(model.logintime.toString()),
    //     textAlign: getTextAlignment(model.logintime.toString()),
    //     style: const TextStyle(
    //       fontSize: 10,
    //     ),
    //   ),
    // )));
    // cellList.add(DataCell(Container(
    //   width: double.infinity,
    //   child: Text(
    //     model.rMName.toString(),
    //     textAlign: getTextAlignment(model.rMName.toString()),
    //     style: const TextStyle(
    //       fontSize: 10,
    //     ),
    //   ),
    // )));
    // return cellList;
  }

  String cellText(String s) {
    String splitString = "";
    if (s.contains("/")) {
      splitString = splitStringFromSpace(s);
    }
    if (s.contains(":")) {
      splitString = splitStringFromComma(s);
    }
    return splitString;
  }

  String splitStringFromSpace(String s) {
    var list = s.split(" ");
    return list[0];
  }

  String splitStringFromComma(String s) {
    var list = s.split(".");
    return list[0];
  }

  TextAlign getTextAlignment(String s) {
    if (isNumeric(s)) {
      return TextAlign.center;
    }

    return TextAlign.start;
  }

  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }

  List<RMAttendanceModel> getTableData(List<BaseModel> reportData) {
    List<RMAttendanceModel> attendanceData = [];
    Map<String, dynamic> rawData = HashMap();

    for (var item in reportData) {
      // var rawData = item.toJson();
      // RMAttendanceModel rmAttendanceModel =
      //     RMAttendanceModel(logindate: "", logintime: "", rMName: "");
      // for (var key in rawData.keys) {
      //   if (key == "logindate") {
      //     rmAttendanceModel.logindate = rawData[key].toString();
      //   }
      //   if (key == "logintime") {
      //     rmAttendanceModel.logintime = rawData[key].toString();
      //   }
      //   if (key == "rMName") {
      //     rmAttendanceModel.rMName = rawData[key].toString();
      //   }
      // }
      attendanceData.add(RMAttendanceModel.fromJson(item.toJson()));
      rawData.addEntries(item.toJson().entries);
      //attendanceData.add(rmAttendanceModel);
    }
    rawData.forEach((key, value) {
      print("key: $key, value: $value");
    });
    return attendanceData;
  }

  @override
  Widget build(BuildContext context) {
    return prepareDataTable(getTableData(widget.reportData));
  }

  //Prepair data table
  Widget prepareDataTable(List<RMAttendanceModel>? data) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 4, top: 8.0, bottom: 8),
            child: Text(
              "# is Count, ₹ is Amount",
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.grey, fontSize: 10),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 410),
            child: DataTable(
              dataRowMinHeight: 25,
              dataRowMaxHeight: 30,
              headingRowHeight: 30,
              columnSpacing: 10,
              dividerThickness: 0.7,
              showBottomBorder: true,
              horizontalMargin: 5,
              headingRowColor: MaterialStateColor.resolveWith(
                  (states) => AppColors.primaryColor),
              columns: getTableHeaders(data),
              rows: getTableRows(data),
            ),
          ),
        ],
      ),
    );
  }
}
