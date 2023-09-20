import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:management_app/constants/app_colors.dart';
import 'package:management_app/models/base_model.dart';
import 'package:management_app/models/tdtm_model.dart';

class TDTMAdminDataTableWidget extends StatefulWidget {
  final List<BaseModel> reportData;

  const TDTMAdminDataTableWidget({
    Key? key,
    required this.reportData,
  }) : super(key: key);

  @override
  _TDTMAdminDataTableWidgetState createState() =>
      _TDTMAdminDataTableWidgetState();
}

class _TDTMAdminDataTableWidgetState extends State<TDTMAdminDataTableWidget> {
  @override
  void initState() {
    super.initState();
  }

  //Prepair table headers
  List<DataColumn> getTableHeaders(BaseModel model) {
    List<DataColumn> columns = [];

    var rawData = model.toJson();

    DateTime dateTime = DateTime.now();
    int offset = 5;

    for (var name in rawData.keys) {
      if (name != 'TeamSeq' || name != 'Center') {
        DateTime dateTimeName =
            DateTime(dateTime.year, dateTime.month - offset, dateTime.day);

        String text = DateFormat("MMM").format(dateTimeName);

        if (offset == 4) {
          text = "Name";
        }
        if (offset == 5) {
          text = "S No";
        }

        offset--;

        columns.add(DataColumn(
          numeric: isNumeric(name),
          label: Center(
            child: Text(
              fixHeaderText(text),
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
  List<DataRow> getTableRows(List<BaseModel>? data) {
    List<DataRow> rows = [];

    var i = 0;
    int totalDate1 = 0;
    int totalDate2 = 0;
    int totalDate3 = 0;
    int totalDate4 = 0;

    for (var d in data!) {
      var rawData = d.toJson();
      TDTMModel model = TDTMModel(
          teamSeq: "", center: "", date1: "", date2: "", date3: "", date4: "");

      for (var key in rawData.keys) {
        if (key == "TeamSeq") {
          model.teamSeq = rawData[key].toString();
        }
        if (key == "Center") {
          model.center = rawData[key].toString();
        }
        if (key == "Date1") {
          model.date1 = rawData[key].toString();
        }
        if (key == "Date2") {
          model.date2 = rawData[key].toString();
        }
        if (key == "Date3") {
          model.date3 = rawData[key].toString();
        }
        if (key == "Date4") {
          model.date4 = rawData[key].toString();
        }
      }

      rows.add(DataRow(cells: getCells(model), color: getRowColor(i)));
      i++;

      for (var key in rawData.keys) {
        if (key == "Date1") {
          totalDate1 += int.parse(rawData[key].toString());
        }
        if (key == "Date2") {
          totalDate2 += int.parse(rawData[key].toString());
        }
        if (key == "Date3") {
          totalDate3 += int.parse(rawData[key].toString());
        }
        if (key == "Date4") {
          totalDate4 += int.parse(rawData[key].toString());
        }
      }
    }

    // Create the total row
    DataRow totalRow = DataRow(
        color: MaterialStateColor.resolveWith((states) => Colors.grey.shade400),
        cells: [
          DataCell(Text('')),
          DataCell(Text('Total')),
          DataCell(Center(
            child: Text(
              totalDate1.toString(),
              style: const TextStyle(
                fontSize: 10,
              ),
            ),
          )),
          DataCell(Center(
            child: Text(totalDate2.toString(),
                style: const TextStyle(
                  fontSize: 10,
                )),
          )),
          DataCell(Center(
            child: Text(totalDate3.toString(),
                style: const TextStyle(
                  fontSize: 10,
                )),
          )),
          DataCell(Center(
            child: Text(totalDate4.toString(),
                style: const TextStyle(
                  fontSize: 10,
                )),
          )),
        ]);

    rows.add(totalRow);

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
  List<DataCell> getCells(TDTMModel model) {
    List<DataCell> cellList = [];
    cellList.add(DataCell(Container(
      width: double.infinity,
      child: Text(
        model.teamSeq.toString(),
        textAlign: getTextAlignment(model.teamSeq.toString()),
        style: const TextStyle(
          fontSize: 10,
        ),
      ),
    )));
    cellList.add(DataCell(Container(
      width: double.infinity,
      child: Text(
        model.center.toString(),
        textAlign: getTextAlignment(model.center.toString()),
        style: const TextStyle(
          fontSize: 10,
        ),
      ),
    )));
    cellList.add(DataCell(Container(
      width: double.infinity,
      child: Text(
        model.date4.toString(),
        textAlign: getTextAlignment(model.date4.toString()),
        style: const TextStyle(
          fontSize: 10,
        ),
      ),
    )));
    cellList.add(DataCell(Container(
      width: double.infinity,
      child: Text(
        model.date3.toString(),
        textAlign: getTextAlignment(model.date3.toString()),
        style: const TextStyle(
          fontSize: 10,
        ),
      ),
    )));
    cellList.add(DataCell(Container(
      width: double.infinity,
      child: Text(
        model.date2.toString(),
        textAlign: getTextAlignment(model.date2.toString()),
        style: const TextStyle(
          fontSize: 10,
        ),
      ),
    )));
    cellList.add(DataCell(Container(
      width: double.infinity,
      child: Text(
        model.date1.toString(),
        textAlign: getTextAlignment(model.date1.toString()),
        style: const TextStyle(
          fontSize: 10,
        ),
      ),
    )));
    return cellList;
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

  @override
  Widget build(BuildContext context) {
    return prepareDataTable(widget.reportData);
  }

  //Prepair data table
  Widget prepareDataTable(List<BaseModel>? data) {
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
            constraints: const BoxConstraints(minWidth: 450),
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
              columns: getTableHeaders(data!.first),
              rows: getTableRows(data),
            ),
          ),
        ],
      ),
    );
  }
}
