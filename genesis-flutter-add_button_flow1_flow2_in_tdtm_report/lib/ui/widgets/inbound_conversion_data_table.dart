import 'package:flutter/material.dart';
import 'package:management_app/constants/app_colors.dart';
import 'package:management_app/models/base_model.dart';

class InboundConversionDataTable extends StatefulWidget {
  final List<BaseModel> reportData;
  const InboundConversionDataTable({Key? key, required this.reportData})
      : super(key: key);

  @override
  State<InboundConversionDataTable> createState() =>
      _InboundConversionDataTableState();
}

class _InboundConversionDataTableState
    extends State<InboundConversionDataTable> {
  @override
  void initState() {
    super.initState();
  }

  //Prepair table headers
  List<DataColumn> getTableHeaders(BaseModel model) {
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
  List<DataRow> getTableRows(List<BaseModel>? data) {
    List<DataRow> rows = [];

    var i = 0;

    int totalPreSales = 0;
    int totalSaleCount = 0;
    int totalSaleAmount = 0;
    int totalOrderCount = 0;

    int totalUpSale = 0;
    int totalOrderNo = 0;
    int totalSalePrecentage = 0;
    int totalOrderPrecentage = 0;

    for (var d in data!) {
      var rawData = d.toJson();

      rows.add(DataRow(cells: getCells(d), color: getRowColor(i)));
      i++;

      for (var key in rawData.keys) {
        if (key == "PreSale") {
          totalPreSales += int.parse(rawData[key].toString());
        }
        if (key == "SaleCount") {
          totalSaleCount += int.parse(rawData[key].toString());
        }
        if (key == "Amount") {
          totalSaleAmount += int.parse(rawData[key].toString());
        }
        if (key == "OrderCount") {
          totalOrderCount += int.parse(rawData[key].toString());
        }
        if (key == "Upsale") {
          totalUpSale += int.parse(rawData[key].toString());
        }
        if (key == "OrderNo") {
          totalOrderNo += int.parse(rawData[key].toString());
        }
        if (key == "SalePercent") {
          totalSalePrecentage += int.parse(rawData[key].toString());
        }
        if (key == "OrderPercent") {
          totalOrderPrecentage += int.parse(rawData[key].toString());
        }
      }
    }

    // Create the total row
    DataRow totalRow = DataRow(
        color: MaterialStateColor.resolveWith((states) => Colors.grey.shade400),
        cells: [
          DataCell(Text('Total')),
          DataCell(Center(
            child: Text(
              totalPreSales.toString(),
              style: const TextStyle(
                fontSize: 10,
              ),
            ),
          )),
          DataCell(Center(
            child: Text(totalSaleCount.toString(),
                style: const TextStyle(
                  fontSize: 10,
                )),
          )),
          DataCell(Center(
            child: Text(totalSaleAmount.toString(),
                style: const TextStyle(
                  fontSize: 10,
                )),
          )),
          DataCell(Center(
            child: Text(totalOrderCount.toString(),
                style: const TextStyle(
                  fontSize: 10,
                )),
          )),
          DataCell(Center(
            child: Text(totalUpSale.toString(),
                style: const TextStyle(
                  fontSize: 10,
                )),
          )),
          DataCell(Center(
            child: Text(totalOrderNo.toString(),
                style: const TextStyle(
                  fontSize: 10,
                )),
          )),
          DataCell(Center(
            child: Text(totalSalePrecentage.toString(),
                style: const TextStyle(
                  fontSize: 10,
                )),
          )),
          DataCell(Center(
            child: Text(totalOrderPrecentage.toString(),
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
  List<DataCell> getCells(BaseModel model) {
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
