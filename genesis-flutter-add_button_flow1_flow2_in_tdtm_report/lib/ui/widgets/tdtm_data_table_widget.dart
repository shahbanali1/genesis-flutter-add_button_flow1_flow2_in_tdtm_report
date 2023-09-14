import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:management_app/constants/app_colors.dart';
import 'package:management_app/constants/constant.dart';
import 'package:management_app/models/base_model.dart';
import 'package:management_app/models/tdtm_model.dart';
import 'package:management_app/models/todal_tdtm_model.dart';
import 'package:management_app/utils/common_utils.dart';

class TDTMDataTableWidget extends StatefulWidget {
  final List<BaseModel> reportData;

  const TDTMDataTableWidget({
    Key? key,
    required this.reportData,
  }) : super(key: key);

  @override
  _TDTMDataTableWidgetState createState() => _TDTMDataTableWidgetState();
}

enum TDTM { Total, Retail, Inbound, Hotspot, HM }

class _TDTMDataTableWidgetState extends State<TDTMDataTableWidget> {
  List<bool> isSelected = [true, false, false, false, false];
  String selectedType = "Total"; //0=Total,1=RETAIL,2=INBOUND,3=HOTSPOT,4=HM

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

    //String text = "";

    DateTime dateTime = DateTime.now();
    int offset = 4;

    for (var name in rawData.keys) {
      if (name != 'TeamSeq') {
        DateTime dateTimeName =
            DateTime(dateTime.year, dateTime.month - offset, dateTime.day);

        String text = DateFormat("MMM").format(dateTimeName);

        if (offset == 4) {
          text = "Name";
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
  List<DataRow> getTableRows(List<TDTMModel> modelList) {
    List<DataRow> rows = [];

    for (int j = 0; j < modelList.length; j++) {
      TDTMModel model = modelList[j];
      rows.add(DataRow(cells: getCells(model), color: getRowColor(j)));
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
  List<DataCell> getCells(TDTMModel model) {
    List<DataCell> cellList = [];
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
        model.date1.toString(),
        textAlign: getTextAlignment(model.date1.toString()),
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
        model.date4.toString(),
        textAlign: getTextAlignment(model.date4.toString()),
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
    List<TotalTDTM> totalTDTM =
        setTDTMListAndChartData(selectedType, widget.reportData);
    List<TDTMModel> tdtmModelList = [];
    for (TotalTDTM item in totalTDTM) {
      TDTMModel model = TDTMModel(
        teamSeq: '001',
        center: item.center,
        date1: item.secondLastMonthRevenue.toString(),
        date2: item.lastMonthRevenue.toString(),
        date3: item.previousMonthRevenue.toString(),
        date4: item.currentMonthRevenue.toString(),
      );
      tdtmModelList.add(model);
    }

    return prepareDataTable(tdtmModelList);
  }

  //Prepair data table
  Widget prepareDataTable(List<TDTMModel> modelList) {
    // setTDTMListAndChartData(selectedType, data);
    return Column(
      children: [
        getTabView(),
        SizedBox(height: 12),
        prepareChartData(modelList),
        SizedBox(height: 8),
        prepareListData(modelList),
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
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Text(
              Constant.tabTotal,
              style: TextStyle(
                  color: getTextColor(selectedType == Constant.tabTotal)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Text(
              Constant.tabRetail,
              style: TextStyle(
                  color: getTextColor(selectedType == Constant.tabRetail)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Text(
              Constant.tabInbound,
              style: TextStyle(
                  color: getTextColor(selectedType == Constant.tabInbound)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Text(
              Constant.tabHotspot,
              style: TextStyle(
                  color: getTextColor(selectedType == Constant.tabHotspot)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Text(
              Constant.tabHM,
              style: TextStyle(
                  color: getTextColor(selectedType == Constant.tabHM)),
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

  Widget prepareChartData(List<TDTMModel> chartData) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 250,
            maxWidth: 350,
            minHeight: 290,
            maxHeight: 360,
          ),
          child: RenderGraphWidget(chartData: chartData),
        ),
      ),
    );
  }

  Widget prepareListData(List<TDTMModel> modelList) {
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
        columns: getTableHeaders(widget.reportData.first),
        rows: getTableRows(modelList),
      ),
    );
  }

  List<TotalTDTM> setTDTMListAndChartData(
      String tdtmTab, List<BaseModel>? data) {
    List<TotalTDTM> totalTDTMList = [];
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
            case Constant.tabInbound:
              if (model.center == "Inbound" ||
                  model.center == "Inbound-FB" ||
                  model.center == "Inbound-google" ||
                  model.center == "Inbound-JD" ||
                  model.center == "Inbound-Exist" ||
                  model.center == "Inbound-SMS" ||
                  model.center == "Inb-Cancel") {
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
              if (model.center == "Hotspot (GGN)") {
                TotalTDTM hotspotGGN_TDTM = new TotalTDTM();
                hotspotGGN_TDTM.setCenter(model.center);
                if (CommonUtils.notNullParams(model.date1)) {
                  hotspotGGN_TDTM
                      .setCurrentMonthRevenue(int.parse(model.date1));
                  currentTotal_or_Date1 = currentTotal_or_Date1 +
                      hotspotGGN_TDTM.getCurrentMonthRevenue();
                }
                if (CommonUtils.notNullParams(model.date2)) {
                  hotspotGGN_TDTM
                      .setPreviousMonthRevenue(int.parse(model.date2));
                  prevTotal_or_Date2 = prevTotal_or_Date2 +
                      hotspotGGN_TDTM.getPreviousMonthRevenue();
                }
                if (CommonUtils.notNullParams(model.date3)) {
                  hotspotGGN_TDTM.setLastMonthRevenue(int.parse(model.date3));
                  lastTotal_or_Date3 = lastTotal_or_Date3 +
                      hotspotGGN_TDTM.getLastMonthRevenue();
                }
                if (CommonUtils.notNullParams(model.date4)) {
                  hotspotGGN_TDTM
                      .setSecondLastMonthRevenue(int.parse(model.date4));
                  secondLastTotal_or_Date4 = secondLastTotal_or_Date4 +
                      hotspotGGN_TDTM.getSecondLastMonthRevenue();
                }
                totalTDTMList.add(hotspotGGN_TDTM);
              } else if (model.center == "Hotspot (PV)") {
                TotalTDTM hotspotPV_TDTM = new TotalTDTM();
                hotspotPV_TDTM.setCenter(model.center);
                if (CommonUtils.notNullParams(model.date1)) {
                  hotspotPV_TDTM.setCurrentMonthRevenue(int.parse(model.date1));
                  currentTotal_or_Date1 = currentTotal_or_Date1 +
                      hotspotPV_TDTM.getCurrentMonthRevenue();
                }
                if (CommonUtils.notNullParams(model.date2)) {
                  hotspotPV_TDTM
                      .setPreviousMonthRevenue(int.parse(model.date2));
                  prevTotal_or_Date2 = prevTotal_or_Date2 +
                      hotspotPV_TDTM.getPreviousMonthRevenue();
                }
                if (CommonUtils.notNullParams(model.date3)) {
                  hotspotPV_TDTM.setLastMonthRevenue(int.parse(model.date3));
                  lastTotal_or_Date3 =
                      lastTotal_or_Date3 + hotspotPV_TDTM.getLastMonthRevenue();
                }
                if (CommonUtils.notNullParams(model.date4)) {
                  hotspotPV_TDTM
                      .setSecondLastMonthRevenue(int.parse(model.date4));
                  secondLastTotal_or_Date4 = secondLastTotal_or_Date4 +
                      hotspotPV_TDTM.getSecondLastMonthRevenue();
                }
                totalTDTMList.add(hotspotPV_TDTM);
              } else if (model.center == "Inbound-Hot") {
                TotalTDTM hotspotINB_TDTM = new TotalTDTM();
                hotspotINB_TDTM.setCenter(model.center);
                if (CommonUtils.notNullParams(model.date1)) {
                  hotspotINB_TDTM
                      .setCurrentMonthRevenue(int.parse(model.date1));
                  currentTotal_or_Date1 = currentTotal_or_Date1 +
                      hotspotINB_TDTM.getCurrentMonthRevenue();
                }
                if (CommonUtils.notNullParams(model.date2)) {
                  hotspotINB_TDTM
                      .setPreviousMonthRevenue(int.parse(model.date2));
                  prevTotal_or_Date2 = prevTotal_or_Date2 +
                      hotspotINB_TDTM.getPreviousMonthRevenue();
                }
                if (CommonUtils.notNullParams(model.date3)) {
                  hotspotINB_TDTM.setLastMonthRevenue(int.parse(model.date3));
                  lastTotal_or_Date3 = lastTotal_or_Date3 +
                      hotspotINB_TDTM.getLastMonthRevenue();
                }
                if (CommonUtils.notNullParams(model.date4)) {
                  hotspotINB_TDTM
                      .setSecondLastMonthRevenue(int.parse(model.date4));
                  secondLastTotal_or_Date4 = secondLastTotal_or_Date4 +
                      hotspotINB_TDTM.getSecondLastMonthRevenue();
                }
                totalTDTMList.add(hotspotINB_TDTM);
              }
              break;
            case Constant.tabHM:
              if (model.center == "Health Manager-GGN" ||
                  model.center == "Health Manager-PV") {
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
          }
        }
        switch (tdtmTab) {
          case Constant.tabTotal:
            TotalTDTM corporateTDTM = new TotalTDTM();
            corporateTDTM.setCenter("Corporate");
            corporateTDTM.setCurrentMonthRevenue(corporateDate1);
            corporateTDTM.setPreviousMonthRevenue(corporateDate2);
            corporateTDTM.setLastMonthRevenue(corporateDate3);
            corporateTDTM.setSecondLastMonthRevenue(corporateDate4);
            corporateTDTM.setColor(AppColors.colorCorporate);
            totalTDTMList.add(corporateTDTM);

            TotalTDTM corpRetailTDTM = new TotalTDTM();
            corpRetailTDTM.setCenter("C.Retail");
            corpRetailTDTM.setCurrentMonthRevenue(corpRetailDate1);
            corpRetailTDTM.setPreviousMonthRevenue(corpRetailDate2);
            corpRetailTDTM.setLastMonthRevenue(corpRetailDate3);
            corpRetailTDTM.setSecondLastMonthRevenue(corpRetailDate4);
            corpRetailTDTM.setColor(AppColors.colorCorporate);
            totalTDTMList.add(corpRetailTDTM);

            TotalTDTM hotspotTDTM = new TotalTDTM();
            hotspotTDTM.setCenter("Hotspot");
            hotspotTDTM.setCurrentMonthRevenue(hotspotDate1);
            hotspotTDTM.setPreviousMonthRevenue(hotspotDate2);
            hotspotTDTM.setLastMonthRevenue(hotspotDate3);
            hotspotTDTM.setSecondLastMonthRevenue(hotspotDate4);
            hotspotTDTM.setColor(AppColors.colorHotspot);
            totalTDTMList.add(hotspotTDTM);

            TotalTDTM retailTDTM = new TotalTDTM();
            retailTDTM.setCenter("Retail");
            retailTDTM.setCurrentMonthRevenue(retailDate1);
            retailTDTM.setPreviousMonthRevenue(retailDate2);
            retailTDTM.setLastMonthRevenue(retailDate3);
            retailTDTM.setSecondLastMonthRevenue(retailDate4);
            retailTDTM.setColor(AppColors.colorRetail);
            totalTDTMList.add(retailTDTM);

//                        /**
//                         * Calculate Total TDTM
//                         */
            currentTotal_or_Date1 = currentTotal_or_Date1 +
                corporateDate1 +
                corpRetailDate1 +
                hotspotDate1 +
                retailDate1;
            prevTotal_or_Date2 = prevTotal_or_Date2 +
                corporateDate2 +
                corpRetailDate2 +
                hotspotDate2 +
                retailDate2;
            lastTotal_or_Date3 = lastTotal_or_Date3 +
                corporateDate3 +
                corpRetailDate3 +
                hotspotDate3 +
                retailDate3;
            secondLastTotal_or_Date4 = secondLastTotal_or_Date4 +
                corporateDate4 +
                corpRetailDate4 +
                hotspotDate4 +
                retailDate4;

            TotalTDTM totalTDTM = new TotalTDTM();
            totalTDTM.setCenter("Total");
            totalTDTM.setCurrentMonthRevenue(currentTotal_or_Date1);
            totalTDTM.setPreviousMonthRevenue(prevTotal_or_Date2);
            totalTDTM.setLastMonthRevenue(lastTotal_or_Date3);
            totalTDTM.setSecondLastMonthRevenue(secondLastTotal_or_Date4);
            totalTDTM.setColor(AppColors.primaryColor);
            totalTDTMList.add(totalTDTM);
            break;

          case Constant.tabRetail:
            //Calculate Total TDTM
            TotalTDTM totalRetailTDTM = new TotalTDTM();
            totalRetailTDTM.setCenter("Total");
            totalRetailTDTM.setCurrentMonthRevenue(currentTotal_or_Date1);
            totalRetailTDTM.setPreviousMonthRevenue(prevTotal_or_Date2);
            totalRetailTDTM.setLastMonthRevenue(lastTotal_or_Date3);
            totalRetailTDTM.setSecondLastMonthRevenue(secondLastTotal_or_Date4);
            totalTDTMList.add(totalRetailTDTM);
            break;
          case Constant.tabInbound:
            TotalTDTM totalIbTDTM = new TotalTDTM();
            totalIbTDTM.setCenter("Total");
            totalIbTDTM.setCurrentMonthRevenue(currentTotal_or_Date1);
            totalIbTDTM.setPreviousMonthRevenue(prevTotal_or_Date2);
            totalIbTDTM.setLastMonthRevenue(lastTotal_or_Date3);
            totalIbTDTM.setSecondLastMonthRevenue(secondLastTotal_or_Date4);
            totalTDTMList.add(totalIbTDTM);
            break;
          case Constant.tabHotspot:
            //currentTotal_or_Date1 = currentTotal_or_Date1 + hotspotDate1;
            //prevTotal_or_Date2 = prevTotal_or_Date2 + hotspotDate2;
            //lastTotal_or_Date3 = lastTotal_or_Date3 + hotspotDate3;
            //secondLastTotal_or_Date4 = secondLastTotal_or_Date4 + hotspotDate4;

            TotalTDTM totalHotspotTDTM = new TotalTDTM();
            totalHotspotTDTM.setCenter("Total");
            totalHotspotTDTM.setCurrentMonthRevenue(currentTotal_or_Date1);
            totalHotspotTDTM.setPreviousMonthRevenue(prevTotal_or_Date2);
            totalHotspotTDTM.setLastMonthRevenue(lastTotal_or_Date3);
            totalHotspotTDTM
                .setSecondLastMonthRevenue(secondLastTotal_or_Date4);
            totalTDTMList.add(totalHotspotTDTM);
            break;

          case Constant.tabHM:
            TotalTDTM totalHmTDTM = new TotalTDTM();
            totalHmTDTM.setCenter("Total");
            totalHmTDTM.setCurrentMonthRevenue(currentTotal_or_Date1);
            totalHmTDTM.setPreviousMonthRevenue(prevTotal_or_Date2);
            totalHmTDTM.setLastMonthRevenue(lastTotal_or_Date3);
            totalHmTDTM.setSecondLastMonthRevenue(secondLastTotal_or_Date4);
            totalTDTMList.add(totalHmTDTM);
            break;
        }
      } else {
        print("No Data Available");
      }
    } on Exception catch (_) {
      print("Something went wrong");
    }
    return totalTDTMList;
  }

  //Get text color and anotation
  Widget getChartTextAndColor(
      String selectedTab, List<TDTMModel> totalTDTMList) {
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
                totalTDTMList[0].center,
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
              Text(totalTDTMList[1].center,
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
              Text(totalTDTMList[2].center,
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
              Text(totalTDTMList[3].center,
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
                totalTDTMList[0].center,
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
              Text(totalTDTMList[1].center,
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
              Text(totalTDTMList[2].center,
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
              Text(totalTDTMList[3].center,
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
              Text(totalTDTMList[4].center,
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
              Text(totalTDTMList[5].center,
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
              Text(totalTDTMList[6].center,
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
              Text(totalTDTMList[7].center,
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
              Text(totalTDTMList[8].center,
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
              Text(totalTDTMList[9].center,
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
              Text(totalTDTMList[10].center,
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
              Text(totalTDTMList[11].center,
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
              Text(totalTDTMList[12].center,
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
              Text(totalTDTMList[13].center,
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
              Text(totalTDTMList[14].center,
                  style: TextStyle(color: AppColors.mdtp_done_disabled_dark))
            ],
          ),
          // Row(
          //   children: [
          //     Container(
          //       height: 10,
          //       width: 10,
          //       color: AppColors.colorYellowLt,
          //     ),
          //     SizedBox(
          //       width: 5,
          //     ),
          //     Text(totalTDTMList[15].center,
          //         style: TextStyle(color: AppColors.colorYellowLt))
          //   ],
          // ),
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
                totalTDTMList[0].center,
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
              Text(totalTDTMList[1].center,
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
              Text(totalTDTMList[2].center,
                  style: TextStyle(color: AppColors.colorRetail))
            ],
          ),
          // Row(
          //   children: [
          //     Container(
          //       height: 10,
          //       width: 10,
          //       color: AppColors.colorDirectOrder,
          //     ),
          //     SizedBox(
          //       width: 5,
          //     ),
          //     Text(totalTDTMList[3].center,
          //         style: TextStyle(color: AppColors.colorDirectOrder))
          //   ],
          // ),
          // Row(
          //   children: [
          //     Container(
          //       height: 10,
          //       width: 10,
          //       color: AppColors.colorDragon,
          //     ),
          //     SizedBox(
          //       width: 5,
          //     ),
          //     Text(totalTDTMList[4].center,
          //         style: TextStyle(color: AppColors.colorDragon))
          //   ],
          // ),
          // Row(
          //   children: [
          //     Container(
          //       height: 10,
          //       width: 10,
          //       color: AppColors.colorWeb,
          //     ),
          //     SizedBox(
          //       width: 5,
          //     ),
          //     Text(totalTDTMList[5].center,
          //         style: TextStyle(color: AppColors.colorWeb))
          //   ],
          // ),
          // Row(
          //   children: [
          //     Container(
          //       height: 10,
          //       width: 10,
          //       color: AppColors.colorApp,
          //     ),
          //     SizedBox(
          //       width: 5,
          //     ),
          //     Text(totalTDTMList[6].center,
          //         style: TextStyle(color: AppColors.colorApp))
          //   ],
          // ),
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
                totalTDTMList[0].center,
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
              Text(totalTDTMList[1].center,
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
              Text(totalTDTMList[2].center,
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
                totalTDTMList[0].center,
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
              Text(totalTDTMList[1].center,
                  style: TextStyle(color: AppColors.colorHotspot))
            ],
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}

class RenderGraphWidget extends StatelessWidget {
  final List<TDTMModel> chartData;
  RenderGraphWidget({
    Key? key,
    required this.chartData,
  }) : super(key: key);

  final List<String> totals = ["0", "0", "0", "0"];
  List<Widget> legendsWdigets = [];

  List<BarChartGroupData> getBars() {
    List<BarChartGroupData> bars = [];

    double fromYCurrentMonth = 0;
    double toYCurrentMonth = 0;

    List<BarChartRodStackItem> barStackCurrentMonth = [];

    double fromYPreviousMonth = 0;
    double toYPreviousMonth = 0;

    List<BarChartRodStackItem> barStackPreviousMonth = [];

    double fromYPreviousPrevioustMonth = 0;
    double toYPreviousPreviousMonth = 0;

    List<BarChartRodStackItem> barStackPreviousPreviousMonth = [];

    double fromYLastMonth = 0;
    double toYLastMonth = 0;

    List<BarChartRodStackItem> barStackLastMonth = [];

    chartData.removeLast();

    int colorIndex = 0;
    chartData.forEach((element) {
      toYCurrentMonth += double.parse(element.date4);
      toYPreviousMonth += double.parse(element.date3);
      toYPreviousPreviousMonth += double.parse(element.date2);
      toYLastMonth += double.parse(element.date1);

      print("Data " +
          fromYCurrentMonth.toString() +
          " " +
          toYCurrentMonth.toString());

      var cm = BarChartRodStackItem(fromYCurrentMonth, toYCurrentMonth,
          CommonUtils.colorsList[colorIndex]);

      var pm = BarChartRodStackItem(fromYPreviousMonth, toYPreviousMonth,
          CommonUtils.colorsList[colorIndex]);

      var ppm = BarChartRodStackItem(fromYPreviousPrevioustMonth,
          toYPreviousPreviousMonth, CommonUtils.colorsList[colorIndex]);

      var lm = BarChartRodStackItem(
          fromYLastMonth, toYLastMonth, CommonUtils.colorsList[colorIndex]);

      barStackCurrentMonth.add(cm);
      barStackPreviousMonth.add(pm);
      barStackPreviousPreviousMonth.add(ppm);
      barStackLastMonth.add(lm);

      fromYCurrentMonth = toYCurrentMonth;
      fromYPreviousMonth = toYPreviousMonth;
      fromYPreviousPrevioustMonth = toYPreviousPreviousMonth;
      fromYLastMonth = toYLastMonth;

      totals[0] = fromYCurrentMonth.toInt().toString();
      totals[1] = fromYPreviousMonth.toInt().toString();
      totals[2] = fromYPreviousPrevioustMonth.toInt().toString();
      totals[3] = fromYLastMonth.toInt().toString();

      legendsWdigets.add(
        Row(
          children: [
            Container(
              height: 10,
              width: 10,
              color: CommonUtils.colorsList[colorIndex],
            ),
            SizedBox(
              width: 5,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 75),
              child: Text(
                element.center,
                style: TextStyle(color: CommonUtils.colorsList[colorIndex]),
              ),
            )
          ],
        ),
      );

      colorIndex++;
    });

    BarChartGroupData currentMonth = BarChartGroupData(
      x: 0,
      groupVertically: true,
      barRods: [
        BarChartRodData(
          toY: toYCurrentMonth,
          width: 48,
          color: Colors.transparent,
          borderRadius: BorderRadius.zero,
          rodStackItems: barStackCurrentMonth,
        ),
      ],
    );

    BarChartGroupData previousMonth = BarChartGroupData(
      x: 1,
      barRods: [
        BarChartRodData(
          toY: toYPreviousMonth,
          width: 48,
          color: Colors.transparent,
          borderRadius: BorderRadius.zero,
          rodStackItems: barStackPreviousMonth,
        ),
      ],
    );
    BarChartGroupData previousPreviousMonth = BarChartGroupData(
      x: 2,
      barRods: [
        BarChartRodData(
          toY: toYPreviousPreviousMonth,
          width: 48,
          color: Colors.transparent,
          borderRadius: BorderRadius.zero,
          rodStackItems: barStackPreviousPreviousMonth,
        ),
      ],
    );
    BarChartGroupData lastMonth = BarChartGroupData(
      x: 3,
      barRods: [
        BarChartRodData(
          toY: toYLastMonth,
          width: 48,
          color: Colors.transparent,
          borderRadius: BorderRadius.zero,
          rodStackItems: barStackLastMonth,
        ),
      ],
    );

    bars.add(currentMonth);
    bars.add(previousMonth);
    bars.add(previousPreviousMonth);
    bars.add(lastMonth);

    return bars.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: legendsWdigets,
        ),
        Expanded(
          child: BarChart(
            BarChartData(
              barGroups: getBars(),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 32,
                    getTitlesWidget: bottomTitles,
                  ),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 32,
                    getTitlesWidget: topTitles,
                  ),
                ),
                leftTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget topTitles(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.black, fontSize: 10);
    String text = totals[value.toInt()];

    return SideTitleWidget(
      child: Text(text, style: style),
      axisSide: meta.axisSide,
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.black, fontSize: 10);
    String text;

    DateTime dateTime = DateTime.now();
    int offset = value.toInt();

    DateTime dateTimeName =
        DateTime(dateTime.year, dateTime.month - offset, dateTime.day);

    text = DateFormat("MMM").format(dateTimeName);

    return SideTitleWidget(
      child: Text(text, style: style),
      axisSide: meta.axisSide,
    );
  }

  BarChartGroupData barChartGroupData(
      {required List<BarChartRodStackItem> colorList,
      required int xaxis,
      required double yaxis}) {
    return BarChartGroupData(x: xaxis, barRods: [
      BarChartRodData(
        toY: yaxis,
        width: 48,
        color: Colors.transparent,
        borderRadius: BorderRadius.zero,
        rodStackItems: colorList,
      ),
    ]);
  }
}
