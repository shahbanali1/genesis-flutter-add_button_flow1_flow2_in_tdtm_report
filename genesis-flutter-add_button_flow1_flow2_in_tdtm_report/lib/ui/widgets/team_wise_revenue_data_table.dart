import 'package:flutter/material.dart';
import 'package:management_app/constants/app_colors.dart';
import 'package:management_app/models/base_model.dart';
import 'package:management_app/models/team_wise_revenue_model.dart';

class TeamWiseRevenueDataTable extends StatefulWidget {
  final List<BaseModel> reportData;
  const TeamWiseRevenueDataTable({Key? key, required this.reportData})
      : super(key: key);

  @override
  State<TeamWiseRevenueDataTable> createState() =>
      _TeamWiseRevenueDataTableState();
}

class _TeamWiseRevenueDataTableState extends State<TeamWiseRevenueDataTable> {
  @override
  void initState() {
    super.initState();
    //prepareData(widget.reportData);
  }

  List<TeamWiseRevenueModel> prepareData(List<BaseModel>? data) {
    List<TeamWiseRevenueModel> teamWiseRevenueModelList = [];

    //    String TeamSeq = "";1
    // String TeamLocation = "";1
    // String TeamName = "";1
    // String TL = "";1
    // String SumofPricePaid = "";1
    // String NoofOrders = "";1
    // String AvgOrderSize = "";1
    // String MAN_DAYS = "";1
    // String perSeatProductivity = "";1
    // String teamWisePricePaid = "";

    //     {
    //   "TeamSeq": "1",
    //   "TeamLocation": "PV",
    //   "TeamName": "Achievers",
    //   "TL": "Shubham Jain",
    //   "SumofPricePaid": "0",
    //   "NoofOrders": "0",
    //   "MAN_DAYS": "0"
    // },

    for (var d in data!) {
      var rawData = d.toJson();
      TeamWiseRevenueModel teamWiseRevenueModel = TeamWiseRevenueModel(
          TeamSeq: "",
          TeamLocation: "",
          TeamName: "",
          TL: "",
          SumofPricePaid: "",
          NoofOrders: "",
          AvgOrderSize: "",
          MAN_DAYS: "",
          perSeatProductivity: "",
          teamWisePricePaid: "");
      for (var key in rawData.keys) {
        double sumOfPricePaid = 0;
        double noOfOrders = 0;
        if (key == "TeamSeq") {
          teamWiseRevenueModel.TeamSeq = rawData[key].toString();
        }
        if (key == "TeamLocation") {
          teamWiseRevenueModel.TeamLocation = rawData[key].toString();
        }
        if (key == "TeamName") {
          teamWiseRevenueModel.TeamName = rawData[key].toString();
        }
        if (key == "TL") {
          teamWiseRevenueModel.TL = rawData[key].toString();
        }
        if (key == "SumofPricePaid") {
          teamWiseRevenueModel.SumofPricePaid = rawData[key].toString();
          teamWiseRevenueModel.perSeatProductivity = rawData[key].toString();
          sumOfPricePaid = double.parse(rawData[key].toString());
        }
        if (key == "NoofOrders") {
          teamWiseRevenueModel.NoofOrders = rawData[key].toString();
          noOfOrders = double.parse(rawData[key].toString());
        }
        if (sumOfPricePaid > 0 && noOfOrders > 0) {
          var avgValue = sumOfPricePaid / noOfOrders;
          if (avgValue > 0) {
            teamWiseRevenueModel.AvgOrderSize = avgValue.toString();
          } else {
            teamWiseRevenueModel.AvgOrderSize = "0";
          }
          // teamWiseRevenueModel.AvgOrderSize =
          //     (sumOfPricePaid / noOfOrders).toString();
        }
        if (key == "MAN_DAYS") {
          teamWiseRevenueModel.MAN_DAYS = rawData[key].toString();
        }
        if (sumOfPricePaid > 0) {
          var total = sumOfPricePaid + sumOfPricePaid;
          if (total > 0) {
            teamWiseRevenueModel.perSeatProductivity = total.toString();
          } else {
            teamWiseRevenueModel.perSeatProductivity = "0";
          }
        }
      }
      teamWiseRevenueModelList.add(teamWiseRevenueModel);
    }
    return teamWiseRevenueModelList;
  }

  //Prepair table headers
  List<DataColumn> getTableHeaders(TeamWiseRevenueModel model) {
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
  List<DataRow> getTableRows(List<TeamWiseRevenueModel>? data) {
    List<DataRow> rows = [];

    var i = 0;

    double totalSumOfPaidPrice = 0;
    double totalNoofOrders = 0;
    double totalAvgOrderSize = 0;
    double totalMAN_DAYS = 0;

    double totalperSeatProductivity = 0;
    double totalteamWisePricePaid = 0;

    for (var d in data!) {
      var rawData = d.toJson();

      rows.add(DataRow(cells: getCells(d), color: getRowColor(i)));
      i++;

      //    String TeamSeq = "";1
      // String TeamLocation = "";1
      // String TeamName = "";1
      // String TL = "";1
      // String SumofPricePaid = "";1
      // String NoofOrders = "";1
      // String AvgOrderSize = "";1
      // String MAN_DAYS = "";1
      // String perSeatProductivity = "";1
      // String teamWisePricePaid = "";

      for (var key in rawData.keys) {
        if (key == "SumofPricePaid") {
          totalSumOfPaidPrice += double.parse(rawData[key].toString());
        }
        if (key == "NoofOrders") {
          totalNoofOrders += double.parse(rawData[key].toString());
        }
        if (key == "AvgOrderSize") {
          //totalAvgOrderSize += double.parse(rawData[key].toString());
        }
        if (key == "MAN_DAYS") {
          totalMAN_DAYS += double.parse(rawData[key].toString());
        }
        if (key == "perSeatProductivity") {
          totalperSeatProductivity += double.parse(rawData[key].toString());
        }
        if (key == "teamWisePricePaid") {
          //totalteamWisePricePaid += double.parse(rawData[key].toString());
        }
      }
    }

    // Create the total row
    DataRow totalRow = DataRow(
        color: MaterialStateColor.resolveWith((states) => Colors.grey.shade400),
        cells: [
          DataCell(Text('')),
          DataCell(Text('')),
          DataCell(Text('')),
          DataCell(Text('Total')),
          DataCell(Center(
            child: Text(totalSumOfPaidPrice.toString(),
                style: const TextStyle(
                  fontSize: 10,
                )),
          )),
          DataCell(Center(
            child: Text(totalNoofOrders.toString(),
                style: const TextStyle(
                  fontSize: 10,
                )),
          )),
          DataCell(Center(
            child: Text(totalAvgOrderSize.toString(),
                style: const TextStyle(
                  fontSize: 10,
                )),
          )),
          DataCell(Center(
            child: Text(totalMAN_DAYS.toString(),
                style: const TextStyle(
                  fontSize: 10,
                )),
          )),
          DataCell(Center(
            child: Text(totalperSeatProductivity.toString(),
                style: const TextStyle(
                  fontSize: 10,
                )),
          )),
          DataCell(Center(
            child: Text(totalteamWisePricePaid.toString(),
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
  List<DataCell> getCells(TeamWiseRevenueModel model) {
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
  Widget prepareDataTable(List<TeamWiseRevenueModel>? data) {
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
