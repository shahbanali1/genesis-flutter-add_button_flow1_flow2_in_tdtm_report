import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:management_app/constants/app_colors.dart';
import 'package:management_app/models/base_model.dart';
import 'package:management_app/models/projection_model.dart';

class ProjectionDataTableWidget extends StatefulWidget {
  final List<BaseModel> reportData;

  const ProjectionDataTableWidget({
    Key? key,
    required this.reportData,
  }) : super(key: key);

  @override
  _ProjectionDataTableWidgetState createState() =>
      _ProjectionDataTableWidgetState();
}

class _ProjectionDataTableWidgetState extends State<ProjectionDataTableWidget> {
  @override
  void initState() {
    super.initState();
  }

  List<ProjectionModel> prepareData(List<BaseModel>? data) {
    List<ProjectionModel> teamWiseRevenueModelList = [];

    // String TeamSeq = "";1
    // String TeamLocation = "";1
    // String SumofPricePaid = "";1
    // String MAN_DAYS = "";1
    // String NoofOrders = "";1
    // String AvgOrderSize = "";1
    // String perSeatProductivity = "";1
    // String teamWisePricePaid = "";

    // {
    //   "TeamSeq":"1",
    //   "TeamLocation":"PV",
    //   "TeamName":"Achievers",
    //   "TL":"Shubham Jain",
    //   "SumofPricePaid":"0",
    //   "NoofOrders":"0",
    //   "MAN_DAYS":"0"
    // }

    for (var d in data!) {
      var rawData = d.toJson();
      ProjectionModel projectionModel = ProjectionModel(
          TeamSeq: "",
          TeamLocation: "",
          SumofPricePaid: "",
          MAN_DAYS: "",
          perSeatProductivity: "",
          AvgManDays: "",
          ProjTeamWise: "");

      for (var key in rawData.keys) {
        if (key == "TeamSeq") {
          projectionModel.TeamSeq = rawData[key].toString();
        }
        if (key == "TeamLocation") {
          projectionModel.TeamLocation = rawData[key].toString();
        }
        if (key == "SumofPricePaid") {
          projectionModel.SumofPricePaid = rawData[key].toString();
          projectionModel.perSeatProductivity = rawData[key].toString();
        }
        if (key == "MAN_DAYS") {
          projectionModel.MAN_DAYS = rawData[key].toString();
          projectionModel.AvgManDays = rawData[key].toString();
          projectionModel.ProjTeamWise = rawData[key].toString();
        }
        // if (key == "AvgManDays") {
        //   projectionModel.AvgManDays = rawData[key].toString();
        // }
        // if (key == "ProjTeamWise") {
        //   projectionModel.ProjTeamWise = rawData[key].toString();
        // }
      }
      teamWiseRevenueModelList.add(projectionModel);
    }
    return teamWiseRevenueModelList;
  }

  //Prepair table headers
  List<DataColumn> getTableHeaders(ProjectionModel model) {
    List<DataColumn> columns = [];

    var rawData = model.toJson();

    for (var name in rawData.keys) {
      columns.add(DataColumn(
        numeric: isNumeric(name),
        label: Center(
          child: Text(
            fixHeaderText(name),
            style: const TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                fontSize: 12),
          ),
        ),
      ));
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
  List<DataRow> getTableRows(List<ProjectionModel>? data) {
    List<DataRow> rows = [];

    var i = 0;
    double totalSumOfPricePaid = 0;
    double totalManDays = 0;
    double totalPerSeatProductivity = 0;
    double totalAvgManDays = 0;
    double totalProjTeamWise = 0;
    //double totalTotal = 0;

    //    String TeamSeq = "";
    // String TeamLocation = "";
    // String SumofPricePaid = "";
    // String MAN_DAYS = "";
    // String perSeatProductivity = "";
    // String AvgManDays = "0";
    // String ProjTeamWise = "";
    // String Total = "";

    for (var d in data!) {
      var rawData = d.toJson();

      rows.add(DataRow(cells: getCells(d), color: getRowColor(i)));
      i++;

      for (var key in rawData.keys) {
        if (key == "SumofPricePaid") {
          totalSumOfPricePaid += double.parse(rawData[key].toString());
        }
        if (key == "MAN_DAYS") {
          totalManDays += double.parse(rawData[key].toString());
        }
        if (key == "perSeatProductivity") {
          totalPerSeatProductivity += double.parse(rawData[key].toString());
        }
        if (key == "AvgManDays") {
          totalAvgManDays += double.parse(rawData[key].toString());
        }
        if (key == "ProjTeamWise") {
          totalProjTeamWise += double.parse(rawData[key].toString());
        }
        // if (key == "Total") {
        //   totalTotal += double.parse(rawData[key].toString());
        // }
      }
    }

    // Create the total row
    DataRow totalRow = DataRow(
        color: MaterialStateColor.resolveWith((states) => Colors.grey.shade400),
        cells: [
          DataCell(Text('')),
          DataCell(Text('Total')),
          DataCell(Center(
            child: Text(totalSumOfPricePaid.toString(),
                style: const TextStyle(
                  fontSize: 10,
                )),
          )),
          DataCell(Center(
            child: Text(totalManDays.toString(),
                style: const TextStyle(
                  fontSize: 10,
                )),
          )),
          DataCell(Center(
            child: Text(totalPerSeatProductivity.toString(),
                style: const TextStyle(
                  fontSize: 10,
                )),
          )),
          DataCell(Center(
            child: Text(totalAvgManDays.toString(),
                style: const TextStyle(
                  fontSize: 10,
                )),
          )),
          DataCell(Center(
            child: Text(totalProjTeamWise.toString(),
                style: const TextStyle(
                  fontSize: 10,
                )),
          )),
          // DataCell(Center(
          //   child: Text(totalTotal.toString(),
          //       style: const TextStyle(
          //         fontSize: 10,
          //       )),
          // )),
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
  List<DataCell> getCells(ProjectionModel model) {
    return List<DataCell>.from(
        model.toJson().values.map((e) => DataCell(Container(
              width: double.infinity,
              child: Text(
                e.toString(),
                textAlign: getTextAlignment(e.toString()),
                style: const TextStyle(
                  fontSize: 10,
                ),
              ),
            ))));
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
    return prepareDataTable(prepareData(widget.reportData));
  }

  //Prepair data table
  Widget prepareDataTable(List<ProjectionModel>? data) {
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
              columns: getTableHeaders(data!.first),
              rows: getTableRows(data),
            ),
          ),
        ],
      ),
    );
  }
}
