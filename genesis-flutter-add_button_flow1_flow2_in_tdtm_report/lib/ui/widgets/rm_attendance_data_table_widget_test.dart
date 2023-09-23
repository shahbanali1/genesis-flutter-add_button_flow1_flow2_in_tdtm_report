import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:management_app/constants/app_colors.dart';
import 'package:management_app/models/attendance_login_data_model.dart';
import 'package:management_app/models/attendance_report_model.dart';
import 'package:management_app/models/base_model.dart';

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
  int numOfColumns = 0;
  List<DataColumn> getTableHeaders(List<AttenadnceReportModel> attendanceList) {
    List<DataColumn> columns = [];

    bool shouldAddDate = true;

    for (var data in attendanceList) {
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

      if (data.logins != null) {
        for (var login in data.logins!) {
          String headerName = login.rMName.toString();
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

    numOfColumns = columns.length;

    return columns;
  }

  int getNumColumns(List<AttenadnceReportModel> attendanceList) {
    int numColumns = 1; // Start with 1 for the "Date" column

    for (var data in attendanceList) {
      if (data.logins != null) {
        for (var login in data.logins!) {
          String headerName = login.rMName.toString();
          bool columnExists = attendanceList.any((data) =>
              data.logins != null &&
              data.logins!
                  .any((login) => login.rMName.toString() == headerName));
          if (!columnExists) {
            numColumns++;
          }
        }
      }
    }

    return numColumns;
  }

  String fixHeaderText(String s) {
    s = s.replaceAll("amount", " ₹");
    s = s.replaceAll("Amount", " ₹");

    s = s.replaceAll("count", " #");
    s = s.replaceAll("Count", " #");
    return s;
  }

//Prepair table rows
  List<DataRow> getTableRows(List<AttenadnceReportModel> attendanceList) {
    List<DataRow> rows = [];
    Set<String> addedDates = {};
    //int numColumns = getNumColumns(attendanceList);

    var i = 0;

    for (var attendanceData in attendanceList) {
      rows.add(DataRow(
          cells: getCells(attendanceData, numOfColumns),
          color: getRowColor(i)));
      i++;

      // if (attendanceData.logins != null) {
      //   for (var login in attendanceData.logins!) {

      //     if (login.loginTime != null) {
      //       rows.add(DataRow(cells: getCells(login), color: getRowColor(i)));
      //     }
      //   }
      // }
      // for (var key in rawData.keys) {
      //   if (key == "logindate") {
      //     String date = d.logindate.toString();
      //     if (!addedDates.contains(date)) {
      //       rows.add(
      //           DataRow(cells: getCells(d), color: getRowColor(rows.length)));
      //       addedDates.add(date);
      //     }
      //   }
      //   if (key == "logintime") {
      //     rows.add(DataRow(cells: getCells(d), color: getRowColor(i)));
      //   }
      //   i++;
      // }
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
  List<DataCell> getCells(AttenadnceReportModel model, int numColumns) {
    List<DataCell> cellList = [];

    cellList.add(DataCell(Container(
      width: double.infinity,
      child: Text(
        splitStringFromSpace(model.loginDate.toString()),
        textAlign: getTextAlignment(model.loginDate.toString()),
        style: const TextStyle(
          fontSize: 10,
        ),
      ),
    )));
    if (model.logins != null) {
      for (var login in model.logins!) {
        cellList.add(DataCell(Container(
          width: double.infinity,
          child: Text(
            splitStringFromComma(login.loginTime.toString()),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
            ),
          ),
        )));
      }
    }
    // Add empty cells if the number of cells is less than the number of columns
    while (cellList.length < numColumns) {
      cellList.add(DataCell(Container(
        width: double.infinity,
        child: Text(
          "-",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 10,
          ),
        ),
      )));
    }
    return cellList;
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

  List<AttenadnceReportModel> getTableData(List<BaseModel> reportData) {
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
                "loginTime": "07:45:55"
            },
            {
                "RMName": "Vishal Singh",
                "loginTime": "06:45:58"
            },
            {
                "RMName": "Ajay Tyagi",
                "loginTime": "05:53:12"
            }
        ]
    },
    {
        "loginDate": "09-22-2023",
        "logins": [
            {
                "RMName": "Manindar Sharma",
                "loginTime": "07:50:55"
            },
            {
                "RMName": "Vishal Singh",
                "loginTime": "06:50:58"
            },
            {
                "RMName": "Ajay Tyagi",
                "loginTime": "05:56:12"
            },
            {
                "RMName": "Manish Sharma",
                "loginTime": "09:15:25"
            }
        ]
    }
  ]
  ''';

    // List<dynamic> parsedData = jsonDecode(jsonData);
    // List<AttenadnceReportModel> attendanceList = [];
    // for (var item in parsedData) {
    //   attendanceList.add(AttenadnceReportModel.fromJson(item));
    // }
    List<AttenadnceReportModel> attendanceList = [];
    // List<Logins> loginsDetailList = [];
    // Logins login = Logins(loginTime: "", rMName: "");
    // AttenadnceReportModel attenadnceReportModel =
    //     AttenadnceReportModel(loginDate: "", logins: loginsDetailList);

    // clearData() {
    //   //attendanceList = [];
    //   loginsDetailList = [];
    //   login = Logins(loginTime: "", rMName: "");
    //   attenadnceReportModel =
    //       AttenadnceReportModel(loginDate: "", logins: loginsDetailList);
    // }

    // for (BaseModel item in reportData) {
    //   Map<String, dynamic> json = item.toJson();
    //   String loginDate = json['logindate'];
    //   String rMName = json['RMName'];
    //   String loginTime = json['logintime'];
    //   print('logindate: $loginDate, RMName: $rMName, logintime: $loginTime');

    //   // attenadnceReportModel = attendanceList.firstWhere(
    //   //     (element) => element.loginDate == loginDate,
    //   //     orElse: () => AttenadnceReportModel(
    //   //         loginDate: loginDate, logins: loginsDetailList));

    //   // if (attenadnceReportModel.loginDate != loginDate) {
    //   //   attenadnceReportModel = AttenadnceReportModel(
    //   //       loginDate: loginDate, logins: loginsDetailList);
    //   //   loginsDetailList = [];
    //   // }

    //   attenadnceReportModel.loginDate = loginDate;
    //   for (BaseModel baseItem in reportData) {
    //     Map<String, dynamic> jsonMap = item.toJson();
    //     if (login.rMName == rMName) {
    //       login.loginTime = loginTime;
    //     }
    //   }
    //   login.rMName = rMName;
    //   login.loginTime = loginTime;

    //   loginsDetailList.add(login);
    //   // if (!attendanceList.any((element) => element.loginDate == loginDate)) {
    //   //   attendanceList.add(attenadnceReportModel);
    //   // }
    //   attendanceList.add(attenadnceReportModel);

    //   clearData();
    // }

    // Create a map to store the grouped data
    Map<String, dynamic> groupedData = {};

    // Iterate through the original data
    for (BaseModel item in reportData) {
      Map<String, dynamic> json = item.toJson();
      String loginDate = json['logindate'].split(' ')[0]; // Extract date
      String rmName = json['RMName'];
      String loginTime = json['logintime'].split('.')[0]; // Remove milliseconds

      // Create a new login entry
      var loginEntry = {
        'RMName': rmName,
        'loginTime': loginTime,
      };

      // Check if the date already exists in the grouped data
      if (groupedData.containsKey(loginDate)) {
        // Add the login entry to the existing date
        groupedData[loginDate]['logins'].add(loginEntry);
      } else {
        // Create a new date entry with the login
        groupedData[loginDate] = {
          'loginDate': loginDate,
          'logins': [loginEntry],
        };
      }
    }

    // Convert the grouped data to a list of maps
    List finalData = groupedData.values.toList();

    // Print the final data
    print(jsonEncode(finalData));

    return attendanceList =
        finalData.map((item) => AttenadnceReportModel.fromJson(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return prepareDataTable(getTableData(widget.reportData));
  }

  //Prepair data table
  Widget prepareDataTable(List<AttenadnceReportModel> data) {
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
