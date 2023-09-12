import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:management_app/constants/app_colors.dart';
import 'package:management_app/constants/constant.dart';
import 'package:management_app/models/base_model.dart';
import 'package:management_app/models/tdtm_model.dart';
import 'package:management_app/models/todal_tdtm_model.dart';
import 'package:management_app/utils/common_utils.dart';

class TDTMDataTableWidget1 extends StatefulWidget {
  final List<BaseModel> reportData;

  const TDTMDataTableWidget1({
    Key? key,
    required this.reportData,
  }) : super(key: key);

  @override
  _TDTMDataTableWidget1State createState() => _TDTMDataTableWidget1State();
}

enum TDTM { Total, Retail, Inbound, Hotspot, HM }

class _TDTMDataTableWidget1State extends State<TDTMDataTableWidget1> {
  List<bool> isSelected = [true, false, false, false, false];
  String selectedType = "Total"; //0=Total,1=RETAIL,2=INBOUND,3=HOTSPOT,4=HM
  List<TotalTDTM> totalTDTMList = [];
  late TDTMModel tdtmModel;

  Color? getTextColor(bool isSelected) {
    if (isSelected) {
      return Colors.white;
    }

    return AppColors.primaryColor;
  }

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

    for (var d in data!) {
      rows.add(DataRow(cells: getCells(d), color: getRowColor(i)));
      i++;
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
    setTDTMListAndChartData(selectedType, data);
    return Column(
      children: [
        getTabView(),
        SizedBox(
          height: 12,
        ),
        PrepareChartData(data),
        SizedBox(
          height: 8,
        ),
        prepareListData(data),
      ],
    );
  }

  getTabView() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ToggleButtons(
        selectedColor: AppColors.primaryColor,
        fillColor: AppColors.primaryColor,
        borderColor: AppColors.primaryColor,
        borderWidth: 1,
        renderBorder: true,
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        disabledColor: Colors.blueGrey,
        disabledBorderColor: Colors.blueGrey,
        focusColor: Colors.red,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                Constant.tabTotal,
                style: TextStyle(
                    color: getTextColor(selectedType == Constant.tabTotal)),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                Constant.tabRetail,
                style: TextStyle(
                    color: getTextColor(selectedType == Constant.tabRetail)),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                Constant.tabInbound,
                style: TextStyle(
                    color: getTextColor(selectedType == Constant.tabInbound)),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                Constant.tabHotspot,
                style: TextStyle(
                    color: getTextColor(selectedType == Constant.tabHotspot)),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                Constant.tabHM,
                style: TextStyle(
                    color: getTextColor(selectedType == Constant.tabHM)),
              ),
            ),
          ),
        ],
        onPressed: (int index) {
          setState(() {
            for (int indexBtn = 0; indexBtn < isSelected.length; indexBtn++) {
              if (index == 0) {
                selectedType = Constant.tabTotal;
              } else if (index == 1) {
                selectedType = Constant.tabRetail;
              } else if (index == 2) {
                selectedType = Constant.tabInbound;
              } else if (index == 3) {
                selectedType = Constant.tabHotspot;
              } else if (index == 4) {
                selectedType = Constant.tabHM;
              }
              if (indexBtn == index) {
                isSelected[indexBtn] = !isSelected[indexBtn];
              } else {
                isSelected[indexBtn] = false;
              }
            }
          });
        },
        isSelected: isSelected,
      ),
    );
  }

  Widget PrepareChartData(List<BaseModel>? data) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getChartTextAndColor(selectedType, totalTDTMList),
            ConstrainedBox(
              constraints: const BoxConstraints(
                  minWidth: 300, minHeight: 280, maxHeight: 300, maxWidth: 400),
              child: BarChart(BarChartData(groupsSpace: 10, barGroups: [
                BarChartGroupData(x: 135, barRods: [
                  BarChartRodData(
                      toY: 20,
                      width: 40,
                      color: Colors.amber,
                      borderRadius: BorderRadius.zero,
                      rodStackItems: [
                        BarChartRodStackItem(0, 2, Colors.red),
                        BarChartRodStackItem(2, 8, Colors.green),
                        BarChartRodStackItem(8, 16, Colors.blue),
                      ]),
                ]),
                BarChartGroupData(x: 56, barRods: [
                  BarChartRodData(
                      toY: 25,
                      width: 40,
                      color: Colors.blue,
                      borderRadius: BorderRadius.zero,
                      rodStackItems: [
                        BarChartRodStackItem(0, 2, Colors.red),
                        BarChartRodStackItem(2, 8, Colors.green),
                        BarChartRodStackItem(8, 16, Colors.blue),
                      ]),
                ]),
                BarChartGroupData(x: 3, barRods: [
                  BarChartRodData(
                      toY: 4,
                      width: 40,
                      color: Colors.red,
                      borderRadius: BorderRadius.zero,
                      rodStackItems: [
                        BarChartRodStackItem(0, 2, Colors.red),
                        BarChartRodStackItem(2, 8, Colors.green),
                        BarChartRodStackItem(8, 16, Colors.blue),
                      ]),
                ]),
                BarChartGroupData(x: 1, barRods: [
                  BarChartRodData(
                      toY: 20,
                      width: 40,
                      color: Colors.amber,
                      borderRadius: BorderRadius.zero,
                      rodStackItems: [
                        BarChartRodStackItem(0, 2, Colors.red),
                        BarChartRodStackItem(2, 8, Colors.green),
                        BarChartRodStackItem(8, 16, Colors.blue),
                      ]),
                ]),
              ])),
            ),
          ],
        ),
      ),
    );
  }

  Widget prepareListData(List<BaseModel>? data) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 410),
      child: DataTable(
        dataRowHeight: 25,
        headingRowHeight: 30,
        columnSpacing: 10,
        dividerThickness: 0.7,
        showBottomBorder: true,
        horizontalMargin: 5,
        headingRowColor:
            MaterialStateColor.resolveWith((states) => AppColors.primaryColor),
        columns: getTableHeaders(data!.first),
        rows: getTableRows(data),
      ),
    );
  }

  void setTDTMListAndChartData(String tdtmTab, List<BaseModel>? data) {
    int corporateDate1 = 0,
        corporateDate2 = 0,
        corporateDate3 = 0,
        corporateDate4 = 0;
    int corpRetailDate1 = 0,
        corpRetailDate2 = 0,
        corpRetailDate3 = 0,
        corpRetailDate4 = 0;
    int hotspotDate1 = 0, hotspotDate2 = 0, hotspotDate3 = 0, hotspotDate4 = 0;
    int retailDate1 = 0, retailDate2 = 0, retailDate3 = 0, retailDate4 = 0;
    int currentTotal_or_Date1 = 0,
        prevTotal_or_Date2 = 0,
        lastTotal_or_Date3 = 0,
        secondLastTotal_or_Date4 = 0;
    try {
      if (data != null && data.length > 0) {
        for (int i = 0; i < data.length; i++) {
          TDTMModel model = TDTMModel.fromJson(data[i].basejson!);
          switch (tdtmTab) {
            case Constant.tabTotal:
              if (model.center == "Corporate") {
                if (CommonUtils.notNullParams(model.date1)) {
                  corporateDate1 = corporateDate1 + int.parse(model.date1);
                }
                if (CommonUtils.notNullParams(model.date2)) {
                  corporateDate2 = corporateDate2 + int.parse(model.date2);
                }
                if (CommonUtils.notNullParams(model.date3)) {
                  corporateDate3 = corporateDate3 + int.parse(model.date3);
                }
                if (CommonUtils.notNullParams(model.date4)) {
                  corporateDate4 = corporateDate4 + int.parse(model.date4);
                }
              } else if (model.center == "Corp Retail") {
                if (CommonUtils.notNullParams(model.date1)) {
                  corpRetailDate1 = corpRetailDate1 + int.parse(model.date1);
                }
                if (CommonUtils.notNullParams(model.date2)) {
                  corpRetailDate2 = corpRetailDate2 + int.parse(model.date2);
                }
                if (CommonUtils.notNullParams(model.date3)) {
                  corpRetailDate3 = corpRetailDate3 + int.parse(model.date3);
                }
                if (CommonUtils.notNullParams(model.date4)) {
                  corpRetailDate4 = corpRetailDate4 + int.parse(model.date4);
                }
              } else if (model.center == "Inbound-Hot") {
                if (CommonUtils.notNullParams(model.date1)) {
                  hotspotDate1 = hotspotDate1 + int.parse(model.date1);
                }
                if (CommonUtils.notNullParams(model.date2)) {
                  hotspotDate2 = hotspotDate2 + int.parse(model.date2);
                }
                if (CommonUtils.notNullParams(model.date3)) {
                  hotspotDate3 = hotspotDate3 + int.parse(model.date3);
                }
                if (CommonUtils.notNullParams(model.date4)) {
                  hotspotDate4 = hotspotDate4 + int.parse(model.date4);
                }
              } else if (model.center == "Hotspot (GGN)") {
                if (CommonUtils.notNullParams(model.date1)) {
                  hotspotDate1 = hotspotDate1 + int.parse(model.date1);
                }
                if (CommonUtils.notNullParams(model.date2)) {
                  hotspotDate2 = hotspotDate2 + int.parse(model.date2);
                }
                if (CommonUtils.notNullParams(model.date3)) {
                  hotspotDate3 = hotspotDate3 + int.parse(model.date3);
                }
                if (CommonUtils.notNullParams(model.date4)) {
                  hotspotDate4 = hotspotDate4 + int.parse(model.date4);
                }
              } else if (model.center == "Hotspot (PV)") {
                if (CommonUtils.notNullParams(model.date1)) {
                  hotspotDate1 = hotspotDate1 + int.parse(model.date1);
                }
                if (CommonUtils.notNullParams(model.date2)) {
                  hotspotDate2 = hotspotDate2 + int.parse(model.date2);
                }
                if (CommonUtils.notNullParams(model.date3)) {
                  hotspotDate3 = hotspotDate3 + int.parse(model.date3);
                }
                if (CommonUtils.notNullParams(model.date4)) {
                  hotspotDate4 = hotspotDate4 + int.parse(model.date4);
                }
              } else {
                if (model.center == "GGN") {
                  continue;
                }
                if (CommonUtils.notNullParams(model.date1)) {
                  retailDate1 = retailDate1 + int.parse(model.date1);
                }
                if (CommonUtils.notNullParams(model.date2)) {
                  retailDate2 = retailDate2 + int.parse(model.date2);
                }
                if (CommonUtils.notNullParams(model.date3)) {
                  retailDate3 = retailDate3 + int.parse(model.date3);
                }
                if (CommonUtils.notNullParams(model.date4)) {
                  retailDate4 = retailDate4 + int.parse(model.date4);
                }
              }
              break;
            case Constant.tabRetail:
              if (model.center == "Corporate") {
                continue;
              } else if (model.center == "Corp Retail") {
                continue;
              } else if (model.center == "GGN") {
                continue;
              } else if (model.center == "Inbound-Hot") {
                continue;
              } else if (model.center == "Hotspot (GGN)") {
                continue;
              } else if (model.center == "Hotspot (PV)") {
                continue;
              } else if (model.center == "Hotspot (Ajay)") {
                continue;
              } else if (model.center == "Dragon") {
                continue;
              } else {
                TotalTDTM retailTDTM = new TotalTDTM();
                retailTDTM.setCenter(model.center);

                if (CommonUtils.notNullParams(model.date1)) {
                  retailTDTM.setCurrentMonthRevenue(int.parse(model.date1));
                  currentTotal_or_Date1 = currentTotal_or_Date1 +
                      retailTDTM.getCurrentMonthRevenue();
                }
                if (CommonUtils.notNullParams(model.date2)) {
                  retailTDTM.setPreviousMonthRevenue(int.parse(model.date2));
                  prevTotal_or_Date2 =
                      prevTotal_or_Date2 + retailTDTM.getPreviousMonthRevenue();
                }
                if (CommonUtils.notNullParams(model.date3)) {
                  retailTDTM.setLastMonthRevenue(int.parse(model.date3));
                  lastTotal_or_Date3 =
                      lastTotal_or_Date3 + retailTDTM.getLastMonthRevenue();
                }
                if (CommonUtils.notNullParams(model.date4)) {
                  retailTDTM.setSecondLastMonthRevenue(int.parse(model.date4));
                  secondLastTotal_or_Date4 = secondLastTotal_or_Date4 +
                      retailTDTM.getSecondLastMonthRevenue();
                }
                totalTDTMList.add(retailTDTM);
              }
              break;
            case Constant.tabHotspot:
          }
        }
      } else {
        print("No Data Available");
      }
    } on Exception catch (_) {
      print("Something went wrong");
    }
  }

  //Get text color and anotation
  Widget getChartTextAndColor(
      String selectedTab, List<TotalTDTM> totalTDTMList) {
    if (selectedTab == Constant.tabTotal) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                color: AppColors.colorCorporate,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Corporate",
                style: TextStyle(color: AppColors.colorCorporate),
              )
            ],
          ),
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                color: AppColors.colorHotspot,
              ),
              SizedBox(
                width: 5,
              ),
              Text("C.Retail", style: TextStyle(color: AppColors.colorHotspot))
            ],
          ),
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                color: AppColors.colorRetail,
              ),
              SizedBox(
                width: 5,
              ),
              Text("HotSpot", style: TextStyle(color: AppColors.colorRetail))
            ],
          ),
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                color: AppColors.colorDirectOrder,
              ),
              SizedBox(
                width: 5,
              ),
              Text("Retail",
                  style: TextStyle(color: AppColors.colorDirectOrder))
            ],
          ),
        ],
      );
    } else if (selectedTab == Constant.tabRetail) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                color: AppColors.colorCorporate,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                totalTDTMList[0].getCenter(),
                style: TextStyle(color: AppColors.colorCorporate),
              )
            ],
          ),
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                color: AppColors.colorHotspot,
              ),
              SizedBox(
                width: 5,
              ),
              Text(totalTDTMList[1].getCenter(),
                  style: TextStyle(color: AppColors.colorHotspot))
            ],
          ),
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                color: AppColors.colorRetail,
              ),
              SizedBox(
                width: 5,
              ),
              Text(totalTDTMList[2].getCenter(),
                  style: TextStyle(color: AppColors.colorRetail))
            ],
          ),
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                color: AppColors.colorDirectOrder,
              ),
              SizedBox(
                width: 5,
              ),
              Text(totalTDTMList[3].getCenter(),
                  style: TextStyle(color: AppColors.colorDirectOrder))
            ],
          ),
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                color: AppColors.colorDragon,
              ),
              SizedBox(
                width: 5,
              ),
              Text(totalTDTMList[4].getCenter(),
                  style: TextStyle(color: AppColors.colorDragon))
            ],
          ),
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                color: AppColors.colorWeb,
              ),
              SizedBox(
                width: 5,
              ),
              Text(totalTDTMList[5].getCenter(),
                  style: TextStyle(color: AppColors.colorWeb))
            ],
          ),
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                color: AppColors.colorApp,
              ),
              SizedBox(
                width: 5,
              ),
              Text(totalTDTMList[6].getCenter(),
                  style: TextStyle(color: AppColors.colorApp))
            ],
          ),
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                color: AppColors.colorHealthManger,
              ),
              SizedBox(
                width: 5,
              ),
              Text(totalTDTMList[7].getCenter(),
                  style: TextStyle(color: AppColors.colorHealthManger))
            ],
          ),
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                color: AppColors.colorInbound,
              ),
              SizedBox(
                width: 5,
              ),
              Text(totalTDTMList[8].getCenter(),
                  style: TextStyle(color: AppColors.colorInbound))
            ],
          ),
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                color: AppColors.colorPhlebotomist,
              ),
              SizedBox(
                width: 5,
              ),
              Text(totalTDTMList[9].getCenter(),
                  style: TextStyle(color: AppColors.colorPhlebotomist))
            ],
          ),
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                color: AppColors.colorInbound_google,
              ),
              SizedBox(
                width: 5,
              ),
              Text(totalTDTMList[10].getCenter(),
                  style: TextStyle(color: AppColors.colorInbound_google))
            ],
          ),
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                color: AppColors.colorInbound_jd,
              ),
              SizedBox(
                width: 5,
              ),
              Text(totalTDTMList[11].getCenter(),
                  style: TextStyle(color: AppColors.colorInbound_jd))
            ],
          ),
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                color: AppColors.colorInbound_exist,
              ),
              SizedBox(
                width: 5,
              ),
              Text(totalTDTMList[12].getCenter(),
                  style: TextStyle(color: AppColors.colorInbound_exist))
            ],
          ),
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                color: AppColors.colorInbound_sms,
              ),
              SizedBox(
                width: 5,
              ),
              Text(totalTDTMList[13].getCenter(),
                  style: TextStyle(color: AppColors.colorInbound_sms))
            ],
          ),
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                color: AppColors.mdtp_done_disabled_dark,
              ),
              SizedBox(
                width: 5,
              ),
              Text(totalTDTMList[14].getCenter(),
                  style: TextStyle(color: AppColors.mdtp_done_disabled_dark))
            ],
          ),
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                color: AppColors.colorYellowLt,
              ),
              SizedBox(
                width: 5,
              ),
              Text(totalTDTMList[15].getCenter(),
                  style: TextStyle(color: AppColors.colorYellowLt))
            ],
          ),
        ],
      );
    } else if (selectedTab == Constant.tabInbound) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                color: AppColors.colorCorporate,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                totalTDTMList[0].getCenter(),
                style: TextStyle(color: AppColors.colorCorporate),
              )
            ],
          ),
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                color: AppColors.colorHotspot,
              ),
              SizedBox(
                width: 5,
              ),
              Text(totalTDTMList[1].getCenter(),
                  style: TextStyle(color: AppColors.colorHotspot))
            ],
          ),
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                color: AppColors.colorRetail,
              ),
              SizedBox(
                width: 5,
              ),
              Text(totalTDTMList[2].getCenter(),
                  style: TextStyle(color: AppColors.colorRetail))
            ],
          ),
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                color: AppColors.colorDirectOrder,
              ),
              SizedBox(
                width: 5,
              ),
              Text(totalTDTMList[3].getCenter(),
                  style: TextStyle(color: AppColors.colorDirectOrder))
            ],
          ),
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                color: AppColors.colorDragon,
              ),
              SizedBox(
                width: 5,
              ),
              Text(totalTDTMList[4].getCenter(),
                  style: TextStyle(color: AppColors.colorDragon))
            ],
          ),
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                color: AppColors.colorWeb,
              ),
              SizedBox(
                width: 5,
              ),
              Text(totalTDTMList[5].getCenter(),
                  style: TextStyle(color: AppColors.colorWeb))
            ],
          ),
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                color: AppColors.colorApp,
              ),
              SizedBox(
                width: 5,
              ),
              Text(totalTDTMList[6].getCenter(),
                  style: TextStyle(color: AppColors.colorApp))
            ],
          ),
        ],
      );
    } else if (selectedTab == Constant.tabHotspot) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                color: AppColors.colorCorporate,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                totalTDTMList[0].getCenter(),
                style: TextStyle(color: AppColors.colorCorporate),
              )
            ],
          ),
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                color: AppColors.colorHotspot,
              ),
              SizedBox(
                width: 5,
              ),
              Text(totalTDTMList[1].getCenter(),
                  style: TextStyle(color: AppColors.colorHotspot))
            ],
          ),
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                color: AppColors.colorRetail,
              ),
              SizedBox(
                width: 5,
              ),
              Text(totalTDTMList[2].getCenter(),
                  style: TextStyle(color: AppColors.colorRetail))
            ],
          ),
        ],
      );
    } else if (selectedTab == Constant.tabHM) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                color: AppColors.colorCorporate,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                totalTDTMList[0].getCenter(),
                style: TextStyle(color: AppColors.colorCorporate),
              )
            ],
          ),
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                color: AppColors.colorHotspot,
              ),
              SizedBox(
                width: 5,
              ),
              Text(totalTDTMList[1].getCenter(),
                  style: TextStyle(color: AppColors.colorHotspot))
            ],
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  // Widget getChartTextAndColor() {
  //   if (selectedType == Constant.tabTotal) {
  //     return Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             Container(
  //               height: 10,
  //               width: 10,
  //               color: AppColors.colorCorporate,
  //             ),
  //             SizedBox(
  //               width: 5,
  //             ),
  //             Text(
  //               "Corporate",
  //               style: TextStyle(color: AppColors.colorCorporate),
  //             )
  //           ],
  //         ),
  //         Row(
  //           children: [
  //             Container(
  //               height: 10,
  //               width: 10,
  //               color: AppColors.colorHotspot,
  //             ),
  //             SizedBox(
  //               width: 5,
  //             ),
  //             Text("C.Retail", style: TextStyle(color: AppColors.colorHotspot))
  //           ],
  //         ),
  //         Row(
  //           children: [
  //             Container(
  //               height: 10,
  //               width: 10,
  //               color: AppColors.colorRetail,
  //             ),
  //             SizedBox(
  //               width: 5,
  //             ),
  //             Text("HotSpot", style: TextStyle(color: AppColors.colorRetail))
  //           ],
  //         ),
  //         Row(
  //           children: [
  //             Container(
  //               height: 10,
  //               width: 10,
  //               color: AppColors.colorDirectOrder,
  //             ),
  //             SizedBox(
  //               width: 5,
  //             ),
  //             Text("Retail",
  //                 style: TextStyle(color: AppColors.colorDirectOrder))
  //           ],
  //         ),
  //       ],
  //     );
  //   } else if (selectedType == Constant.tabRetail) {
  //     return Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             Container(
  //               height: 10,
  //               width: 10,
  //               color: AppColors.colorCorporate,
  //             ),
  //             SizedBox(
  //               width: 5,
  //             ),
  //             Text(
  //               "Corporate",
  //               style: TextStyle(color: AppColors.colorCorporate),
  //             )
  //           ],
  //         ),
  //         Row(
  //           children: [
  //             Container(
  //               height: 10,
  //               width: 10,
  //               color: AppColors.colorHotspot,
  //             ),
  //             SizedBox(
  //               width: 5,
  //             ),
  //             Text("C.Retail", style: TextStyle(color: AppColors.colorHotspot))
  //           ],
  //         ),
  //         Row(
  //           children: [
  //             Container(
  //               height: 10,
  //               width: 10,
  //               color: AppColors.colorRetail,
  //             ),
  //             SizedBox(
  //               width: 5,
  //             ),
  //             Text("HotSpot", style: TextStyle(color: AppColors.colorRetail))
  //           ],
  //         ),
  //         Row(
  //           children: [
  //             Container(
  //               height: 10,
  //               width: 10,
  //               color: AppColors.colorDirectOrder,
  //             ),
  //             SizedBox(
  //               width: 5,
  //             ),
  //             Text("Retail",
  //                 style: TextStyle(color: AppColors.colorDirectOrder))
  //           ],
  //         ),
  //       ],
  //     );
  //   } else if (selectedType == Constant.tabInbound) {
  //     return Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             Container(
  //               height: 10,
  //               width: 10,
  //               color: AppColors.colorHotspot,
  //             ),
  //             SizedBox(
  //               width: 5,
  //             ),
  //             Text("C.Retail", style: TextStyle(color: AppColors.colorHotspot))
  //           ],
  //         ),
  //         Row(
  //           children: [
  //             Container(
  //               height: 10,
  //               width: 10,
  //               color: AppColors.colorRetail,
  //             ),
  //             SizedBox(
  //               width: 5,
  //             ),
  //             Text("HotSpot", style: TextStyle(color: AppColors.colorRetail))
  //           ],
  //         ),
  //         Row(
  //           children: [
  //             Container(
  //               height: 10,
  //               width: 10,
  //               color: AppColors.colorDirectOrder,
  //             ),
  //             SizedBox(
  //               width: 5,
  //             ),
  //             Text("Retail",
  //                 style: TextStyle(color: AppColors.colorDirectOrder))
  //           ],
  //         ),
  //       ],
  //     );
  //   } else if (selectedType == Constant.tabHotspot) {
  //     return Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             Container(
  //               height: 10,
  //               width: 10,
  //               color: AppColors.colorCorporate,
  //             ),
  //             SizedBox(
  //               width: 5,
  //             ),
  //             Text(
  //               "Corporate",
  //               style: TextStyle(color: AppColors.colorCorporate),
  //             )
  //           ],
  //         ),
  //         Row(
  //           children: [
  //             Container(
  //               height: 10,
  //               width: 10,
  //               color: AppColors.colorHotspot,
  //             ),
  //             SizedBox(
  //               width: 5,
  //             ),
  //             Text("C.Retail", style: TextStyle(color: AppColors.colorHotspot))
  //           ],
  //         ),
  //         Row(
  //           children: [
  //             Container(
  //               height: 10,
  //               width: 10,
  //               color: AppColors.colorDirectOrder,
  //             ),
  //             SizedBox(
  //               width: 5,
  //             ),
  //             Text("Retail",
  //                 style: TextStyle(color: AppColors.colorDirectOrder))
  //           ],
  //         ),
  //       ],
  //     );
  //   } else
  //     return Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             Container(
  //               height: 10,
  //               width: 10,
  //               color: AppColors.colorCorporate,
  //             ),
  //             SizedBox(
  //               width: 5,
  //             ),
  //             Text(
  //               "Corporate",
  //               style: TextStyle(color: AppColors.colorCorporate),
  //             )
  //           ],
  //         ),
  //         Row(
  //           children: [
  //             Container(
  //               height: 10,
  //               width: 10,
  //               color: AppColors.colorHotspot,
  //             ),
  //             SizedBox(
  //               width: 5,
  //             ),
  //             Text("C.Retail", style: TextStyle(color: AppColors.colorHotspot))
  //           ],
  //         ),
  //         Row(
  //           children: [
  //             Container(
  //               height: 10,
  //               width: 10,
  //               color: AppColors.colorRetail,
  //             ),
  //             SizedBox(
  //               width: 5,
  //             ),
  //             Text("HotSpot", style: TextStyle(color: AppColors.colorRetail))
  //           ],
  //         ),
  //       ],
  //     );
  // }
}
