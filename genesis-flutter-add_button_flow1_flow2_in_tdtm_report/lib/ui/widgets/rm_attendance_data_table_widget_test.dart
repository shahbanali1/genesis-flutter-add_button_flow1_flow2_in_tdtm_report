import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:management_app/constants/app_colors.dart';
import 'package:management_app/models/attendance_report_model.dart';
import 'package:management_app/models/base_model.dart';
import 'package:management_app/models/rm_attendance_model.dart';

class RmAttendanceDataTableWidgetTest extends StatefulWidget {
  final List<BaseModel> reportData;
  const RmAttendanceDataTableWidgetTest({
    Key? key,
    required this.reportData,
  }) : super(key: key);

  @override
  State<RmAttendanceDataTableWidgetTest> createState() =>
      _RmAttendanceDataTableWidgetTestState();
}

class _RmAttendanceDataTableWidgetTestState
    extends State<RmAttendanceDataTableWidgetTest> {
  List<DataColumn> getTableHeaders(List<dynamic> data) {
    List<DataColumn> columns = [];

    // var rawData = model.toJson();
    bool shouldAddDate = true;
    for (var name in data) {
      if (shouldAddDate) {
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
      if (name == "RMName") {
        String headerName = "RMName";
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
  List<DataRow> getTableRows(List<dynamic> data) {
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

  AttenadnceReportModel getTableData(List<BaseModel> reportData) {
    AttenadnceReportModel data = AttenadnceReportModel();
    String jsonData = '''
  [
    {
        "loginDate": "09-20-2023",
        "logins": [
            {
                "RMName": "Manindar Sharma",
                "loginTime": "07:40:55"
            },
            {
                "RMName": "Vishal Singh",
                "loginTime": "06:40:58"
            },
            {
                "RMName": "Ajay Tyagi",
                "loginTime": "05:50:12"
            }
        ]
    },
    {
        "loginDate": "09-21-2023",
        "logins": [
            {
                "RMName": "Manindar Sharma",
                "loginTime": "07:40:55"
            },
            {
                "RMName": "Vishal Singh",
                "loginTime": "06:40:58"
            },
            {
                "RMName": "Ajay Tyagi",
                "loginTime": "05:50:12"
            }
        ]
    },
    {
        "loginDate": "09-22-2023",
        "logins": [
            {
                "RMName": "Manindar Sharma",
                "loginTime": "07:40:55"
            },
            {
                "RMName": "Vishal Singh",
                "loginTime": "06:40:58"
            },
            {
                "RMName": "Ajay Tyagi",
                "loginTime": "05:50:12"
            }
        ]
    }
  ]
  ''';

    data = AttenadnceReportModel.fromJson(jsonDecode(jsonData));

    // Access and print the values
    // for (var item in data) {
    //   String loginDate = item['loginDate'];
    //   List<dynamic> logins = item['logins'];

    //   print('Login Date: $loginDate');
    //   for (var login in logins) {
    //     String rmName = login['RMName'];
    //     String loginTime = login['loginTime'];
    //     print('RMName: $rmName, Login Time: $loginTime');
    //   }
    //   print('---');
    // }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return prepareDataTable(getTableData(widget.reportData));
  }

  //Prepair data table
  Widget prepareDataTable(data) {
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
