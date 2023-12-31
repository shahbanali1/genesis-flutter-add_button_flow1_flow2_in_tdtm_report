import 'dart:async';

import 'package:flutter/material.dart';
import 'package:management_app/constants/app_colors.dart';
import 'package:management_app/constants/screens.dart';
import 'package:management_app/holders/agent_pickup_screen_data_holder.dart';
import 'package:management_app/holders/corporate_report_screen_data_holder.dart';
import 'package:management_app/holders/dept_collection_data_holder.dart';
import 'package:management_app/holders/disposition_data_holder.dart';
import 'package:management_app/holders/govt_lab_screen_data_holder.dart';
import 'package:management_app/holders/hotspot_screen_data_holder.dart';
import 'package:management_app/holders/hotspot_zone_wise_data_holder.dart';
import 'package:management_app/holders/inbound_conversion_data_holder.dart';
import 'package:management_app/holders/inbound_screen_data_holder.dart';
import 'package:management_app/holders/lead_wise_conversion_screen_data_holder.dart';
import 'package:management_app/holders/performance_of_the_day_data_holder.dart';
import 'package:management_app/holders/phlebo_attendance_pickup_data_holder.dart';
import 'package:management_app/holders/projection_data_holder.dart';
import 'package:management_app/holders/rm_attendance_data_holder.dart';
import 'package:management_app/holders/rm_collection_report_data_holder.dart';
import 'package:management_app/holders/rm_pickup_summary_data_holder.dart';
import 'package:management_app/holders/rm_wise_booking_collection_data_holder.dart';
import 'package:management_app/holders/tdtm_admin_screen_data_holder.dart';
import 'package:management_app/holders/tdtm_screen_data_holder.dart';
import 'package:management_app/holders/team_wise_revenue_data_holder.dart';
import 'package:management_app/holders/verifier_screen_data_holder.dart';
import 'package:management_app/holders/zone_wise_collection_data_holder.dart';
import 'package:management_app/models/base_model.dart';
import 'package:management_app/models/phlebo_manager.dart';
import 'package:management_app/ui/screen_handler.dart';
import 'package:management_app/ui/widgets/data_table_widget.dart';
import 'package:management_app/ui/widgets/disposition_data_table.dart';
import 'package:management_app/ui/widgets/inbound_conversion_data_table.dart';
import 'package:management_app/ui/widgets/projection_data_table.dart';
import 'package:management_app/ui/widgets/rm_attendance_data_table_widget_test.dart';
import 'package:management_app/ui/widgets/tdtm_admin_data_table_widget.dart';
import 'package:management_app/ui/widgets/tdtm_data_table_widget.dart';
import 'package:management_app/ui/widgets/team_wise_revenue_data_table.dart';
import 'package:management_app/utils/data_streem.dart';

class ReportScreen extends StatefulWidget {
  final Screens reportToOpen;

  const ReportScreen({Key? key, required this.reportToOpen}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ReportState();
}

class ReportState extends State<ReportScreen> {
  late Future<List<BaseModel>> reportData;

  Stream stream = DataStreem().controller.stream;

  @override
  void initState() {
    super.initState();
    stream.listen((value) {
      if (mounted) {
        setState(() {
          Map map = value;
          var type = map["type"];
          if (type == "verifier") {
            Map value = map["value"];
            reportData = ScreenHandler()
                .getVerifireReport(value["dayType"], value["flowType"]);
          } else if (type == "inbound") {
            Map value = map["value"];
            reportData = ScreenHandler().getInboundReportData(
                value["selectedMonth"], value["selectedTimeSlot"]);
          } else if (type == "hotspot") {
            Map value = map["value"];
            reportData = ScreenHandler().getHotspotReportData(
                value["selectedType"],
                value["selectedMonth"],
                value["selectedTimeSlot"]);
          } else if (type == "agentPickup") {
            Map value = map["value"];
            reportData = ScreenHandler().getAgentPickupReportData(
                value["selectedDate"], value["userRole"], value["location"]);
          } else if (type == "leadWiseConversion") {
            Map value = map["value"];
            reportData = ScreenHandler()
                .getLeadWiseConversionData(value["selectedDate"]);
          } else if (type == "performanceOfTheDay") {
            Map value = map["value"];
            reportData = ScreenHandler().getPerformanceOfTheDayData(
                value["selectedRole"],
                value["selectedLocation"],
                value["selectedCount"]);
          } else if (type == "corporate") {
            Map value = map["value"];
            reportData =
                ScreenHandler().getCorporateReportData(value["selectedDate"]);
          } else if (type == "rmCollectionReport") {
            Map value = map["value"];
            reportData = ScreenHandler().getRMCollectionReportData(
                value["selectedFromDate"], value["selectedToDate"]);
          } else if (type == "tdtmReport") {
            Map value = map["value"];
            reportData = ScreenHandler().getTDTMReportData(
              value["selectedFromDate"],
              value["selectedToDate"],
              value["fromDate2"],
              value["toDate2"],
              value["fromDate3"],
              value["toDate3"],
              value["fromDate4"],
              value["toDate4"],
              value["flow2"],
            );
          } else if (type == "governmentLabReport") {
            Map value = map["value"];
            reportData = ScreenHandler().getGovernmentLabReportData(
                value["selectedFromDate"], value["selectedToDate"]);
          } else if (type == "hotspotZoneWise") {
            Map value = map["value"];
            reportData = ScreenHandler()
                .getHotspotZoneWiseReportData(value["selectedDate"]);
          } else if (type == Screens.inboundTodayStatus) {
            reportData = ScreenHandler().getInboundTodayStatusReportData();
          } else if (type == Screens.routeTracking) {
            reportData = ScreenHandler().getRouteTrackingReportData();
          } else if (type == "tdtmAdminReport") {
            Map value = map["value"];
            reportData = ScreenHandler().getTDTMAdminReportData(
              value["selectedFromDate"],
              value["selectedToDate"],
              value["fromDate2"],
              value["toDate2"],
              value["fromDate3"],
              value["toDate3"],
              value["fromDate4"],
              value["toDate4"],
              value["flow2"],
            );
          } else if (type == "teamWiseRevenue") {
            Map value = map["value"];
            reportData = ScreenHandler().getTeamWiseRevenueReportData(
              value["selectedFromDate"],
              value["selectedToDate"],
            );
          } else if (type == Screens.phleboAttendancePickup) {
            Map value = map["value"];
            reportData = ScreenHandler().getPhleboAttendancePickupReportData(
              value["selectedRM"],
            );
          } else if (type == Screens.phleboAttendanceReport) {
            Map value = map["value"];
            reportData = ScreenHandler().getPhleboAttendancePickupReportData(
              value["selectedRM"],
            );
          } else if (type == Screens.rmPickupSummaryReport) {
            Map value = map["value"];
            reportData = ScreenHandler().getRMPickupSummaryReportData(
              value["selectedFromDate"],
              value["selectedToDate"],
            );
          } else if (type == Screens.rmWiseBookingCollectionReport) {
            Map value = map["value"];
            reportData = ScreenHandler().getRMPickupSummaryReportData(
              value["selectedDate"],
              "09:00-10:00",
            );
          } else if (type == Screens.deptCollectionReport) {
            Map value = map["value"];
            reportData = ScreenHandler().getDEPTCollectionReportData(
              value["selectedFromDate"],
              value["selectedToDate"],
            );
          } else if (type == Screens.inboundConversionReport) {
            Map value = map["value"];
            reportData = ScreenHandler().getInboundConversionReportData(
              value["selectedDate"],
            );
          } else if (type == Screens.zoneWiseCollectionReport) {
            Map value = map["value"];
            reportData = ScreenHandler().getZoneWiseCollectionReportData(
              value["selectedDate"],
              value["selectedTimeSlot"],
            );
          } else if (type == Screens.rmAttendanceReport) {
            Map value = map["value"];
            reportData = ScreenHandler().getRMAttendanceReportData(
              value["selectedFromDate"],
              value["selectedToDate"],
            );
          } else if (type == Screens.projectionReport) {
            Map value = map["value"];
            reportData = ScreenHandler().getProjectionReportData(
              value["selectedFromDate"],
              value["selectedToDate"],
              value["isZeroValuePackage"],
            );
          } else if (type == Screens.dispositionReport) {
            Map value = map["value"];
            reportData = ScreenHandler().getDispositionReportData(
              value["selectedFromDate"],
              value["selectedToDate"],
            );
          }
        });
      }
    });
    initiateApiCall();
  }

  initiateApiCall() {
    switch (widget.reportToOpen) {
      case Screens.verifier:
        reportData = ScreenHandler().getVerifireReport(
            VerifierScreenDataHolder().dayType,
            VerifierScreenDataHolder().flowType);
        break;
      case Screens.inbound:
        reportData = ScreenHandler().getInboundReportData(
            InboundScreenDataHolder().defaultMonth,
            InboundScreenDataHolder().defaultTimeSlot);
        break;
      case Screens.hotspot:
        reportData = ScreenHandler().getHotspotReportData(
            HotSpotScreenDataHolder().reportType,
            HotSpotScreenDataHolder().month,
            HotSpotScreenDataHolder().timeSlot);
        break;
      case Screens.agentPickup:
        reportData = ScreenHandler().getAgentPickupReportData(
            AgentPickupScreenDataHolder().date,
            AgentPickupScreenDataHolder().userRole,
            AgentPickupScreenDataHolder().location);
        break;
      case Screens.leadWiseCon:
        reportData = ScreenHandler().getLeadWiseConversionData(
            LeadWiseConversionScreenDataHolder().leadDate);
        break;
      case Screens.performance:
        reportData = ScreenHandler().getPerformanceOfTheDayData(
            PerformanceOfTheDayDataHolder().process,
            PerformanceOfTheDayDataHolder().location,
            PerformanceOfTheDayDataHolder().count);
        break;
      case Screens.corporate:
        reportData = ScreenHandler()
            .getCorporateReportData(CorporateReportScreenDataHolder().date);
        break;
      case Screens.rmCollection:
        reportData = ScreenHandler().getRMCollectionReportData(
            RMCollectionReportDateHolder().fromDate,
            RMCollectionReportDateHolder().toDate);
        break;
      case Screens.tdtmChart:
        reportData = ScreenHandler().getTDTMReportData(
          TDTMScreenDataHolder().fromDate1,
          TDTMScreenDataHolder().toDate1,
          TDTMScreenDataHolder().fromDate2,
          TDTMScreenDataHolder().toDate2,
          TDTMScreenDataHolder().fromDate3,
          TDTMScreenDataHolder().toDate3,
          TDTMScreenDataHolder().fromDate4,
          TDTMScreenDataHolder().toDate4,
          TDTMScreenDataHolder().flowType,
        );
        break;
      case Screens.govtLab:
        reportData = ScreenHandler().getGovernmentLabReportData(
            GovernmentLabScreenDateHolder().fromDate,
            GovernmentLabScreenDateHolder().toDate);
        break;
      case Screens.hotspotZoneWise:
        reportData = ScreenHandler().getHotspotZoneWiseReportData(
            HotspotZoneWiseScreenDataHolder().selectedDate);
        break;
      case Screens.inboundTodayStatus:
        reportData = ScreenHandler().getInboundTodayStatusReportData();
        break;
      case Screens.routeTracking:
        reportData = ScreenHandler().getRouteTrackingReportData();
        break;
      case Screens.tdtmAdmin:
        reportData = ScreenHandler().getTDTMAdminReportData(
          TDTMAdminScreenDataHolder().fromDate1,
          TDTMAdminScreenDataHolder().toDate1,
          TDTMAdminScreenDataHolder().fromDate2,
          TDTMAdminScreenDataHolder().toDate2,
          TDTMAdminScreenDataHolder().fromDate3,
          TDTMAdminScreenDataHolder().toDate3,
          TDTMAdminScreenDataHolder().fromDate4,
          TDTMAdminScreenDataHolder().toDate4,
          TDTMAdminScreenDataHolder().flowType,
        );
        break;
      case Screens.teamWiseRevenue:
        reportData = ScreenHandler().getTeamWiseRevenueReportData(
            TeamWiseRevenueScreenDataHolder().fromDate,
            TeamWiseRevenueScreenDataHolder().toDate);
        break;
      case Screens.phleboAttendancePickup:
        reportData = ScreenHandler().getPhleboAttendancePickupReportData(
            PhleboAttendancePickupScreenDataHolder().selectedRM);
        break;
      case Screens.phleboAttendanceReport:
        reportData = ScreenHandler().getPhleboAttendancePickupReportData(
            PhleboAttendancePickupScreenDataHolder().selectedRM);
        break;
      case Screens.rmPickupSummaryReport:
        reportData = ScreenHandler().getRMPickupSummaryReportData(
            RMPickupSummaryScreenDataHolder().fromDate,
            RMPickupSummaryScreenDataHolder().toDate);
        break;

      case Screens.rmWiseBookingCollectionReport:
        reportData = ScreenHandler().getRMWiseBookingCollectionReportData(
            RMWiseBookingCollectionDataHolder().fromDate,
            RMWiseBookingCollectionDataHolder().fromDate);
        break;

      case Screens.deptCollectionReport:
        reportData = ScreenHandler().getDEPTCollectionReportData(
            DEPTCollectionDateHolder().fromDate,
            DEPTCollectionDateHolder().toDate);
        break;

      case Screens.inboundConversionReport:
        reportData = ScreenHandler().getInboundConversionReportData(
            InboundConversionDateHolder().selectedDate);
        break;

      case Screens.zoneWiseCollectionReport:
        reportData = ScreenHandler().getZoneWiseCollectionReportData(
            ZoneWiseCollectionDataHolder().selectedDate,
            ZoneWiseCollectionDataHolder().selectedTimeSlot);
        break;

      case Screens.rmAttendanceReport:
        reportData = ScreenHandler().getRMAttendanceReportData(
            RmAttendanceDateHolder().fromDate, RmAttendanceDateHolder().toDate);
        break;

      case Screens.projectionReport:
        reportData = ScreenHandler().getProjectionReportData(
            ProjectionDataHolder().fromDate,
            ProjectionDataHolder().toDate,
            ProjectionDataHolder().specialPackage);
        break;

      case Screens.dispositionReport:
        reportData = ScreenHandler().getDispositionReportData(
            DispositionDataHolder().fromDate, DispositionDataHolder().toDate);
        break;

      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: getReportTitle(),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical, child: getBody()),
    );
  }

  Widget getBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getHeader(),
        //if (widget.reportToOpen == Screens.rmAttendanceReport)
        // FutureBuilder<List<RMAttendanceModel>>(
        //     future: rmAttendanceData,
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState != ConnectionState.done) {
        //         return getLoader();
        //       }

        //       if (snapshot.hasData) {
        //         return RmAttendanceDataTableWidget(
        //           reportData: snapshot.data!,
        //         );
        //       } else {
        //         return const Text("No Data");
        //       }
        //     }),
        FutureBuilder<List<BaseModel>>(
            future: reportData,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return getLoader();
              }

              if (snapshot.hasData) {
                if (widget.reportToOpen == Screens.tdtmChart) {
                  return TDTMDataTableWidget(
                    reportData: snapshot.data!,
                  );
                } else if (widget.reportToOpen ==
                    Screens.phleboAttendancePickup) {
                  return getPhleboAttendancePickupWidget(snapshot.data!);
                } else if (widget.reportToOpen ==
                    Screens.phleboAttendanceReport) {
                  return getPhleboAttendanceReportWidget(snapshot.data!);
                } else if (widget.reportToOpen == Screens.tdtmAdmin) {
                  return TDTMAdminDataTableWidget(reportData: snapshot.data!);
                } else if (widget.reportToOpen ==
                    Screens.inboundConversionReport) {
                  return InboundConversionDataTable(
                    reportData: snapshot.data!,
                  );
                } else if (widget.reportToOpen == Screens.teamWiseRevenue) {
                  return TeamWiseRevenueDataTable(
                    reportData: snapshot.data!,
                  );
                } else if (widget.reportToOpen == Screens.dispositionReport) {
                  return DispositionDataTable(
                    reportData: snapshot.data!,
                  );
                } else if (widget.reportToOpen == Screens.projectionReport) {
                  return ProjectionDataTableWidget(
                    reportData: snapshot.data!,
                  );
                } else if (widget.reportToOpen == Screens.rmAttendanceReport) {
                  return RmAttendanceDataTableWidgetTest(
                    reportData: snapshot.data!,
                  );
                } else {
                  return DataTableWidget(reportData: snapshot.data!);
                }
              } else {
                return const Text("No Data");
              }
            }),
      ],
    );
  }

  Widget getPhleboAttendancePickupWidget(List<BaseModel> reportData) {
    return Column(
      children: [
        ScreenHandler().getPhleboAttendancePickupHeader(
            getUniqueRM(reportData),
            PhleboAttendancePickupScreenDataHolder().selectedRM,
            reportData.length.toString()),
        SizedBox(
          height: 5,
        ),
        DataTableWidget(reportData: reportData),
      ],
    );
  }

  Widget getPhleboAttendanceReportWidget(List<BaseModel> reportData) {
    return Column(
      children: [
        ScreenHandler().getPhleboAttendancePickupHeader(
            getUniqueRM(reportData),
            PhleboAttendancePickupScreenDataHolder().selectedRM,
            reportData.length.toString()),
        SizedBox(
          height: 5,
        ),
        DataTableWidget(reportData: reportData),
      ],
    );
  }

  List<PhleboManager> getUniqueRMWithAll(List<BaseModel> reportData) {
    List<PhleboManager> rmList = [];
    PhleboManager phleboManager =
        PhleboManager(managerName: "All Phlabo Manager", managerId: "844");

    rmList.add(phleboManager);
    for (var d in reportData) {
      rmList.add(PhleboManager(
          managerName: d.basejson!["PhleboManager"].toString(),
          managerId: d.basejson!["U_ID"].toString()));
    }
    List<PhleboManager> result = rmList.toSet().toList();
    return result;
  }

  List<String> getUniqueRM(List<BaseModel> reportData) {
    List<String> rmList = [];
    rmList.add("All");
    for (var d in reportData) {
      rmList.add(d.basejson!["RmName"].toString());
    }
    List<String> result = rmList.toSet().toList();
    return result;
  }

  Widget getHeader() {
    switch (widget.reportToOpen) {
      case Screens.verifier:
        return ScreenHandler().getVerfierHeader();
      case Screens.inbound:
        return ScreenHandler().getInboundHeader();
      case Screens.hotspot:
        return ScreenHandler().getHotSpotHeader();
      case Screens.agentPickup:
        return ScreenHandler().getAgentPickupHeader();
      case Screens.leadWiseCon:
        return ScreenHandler().getLeadWiseConversionHeader();
      case Screens.performance:
        return ScreenHandler().getPerformanceOfTheDayHeader();
      case Screens.corporate:
        return ScreenHandler().getCorporateReportHeader();
      case Screens.rmCollection:
        return ScreenHandler().getRMCollecctionReportHeader();
      case Screens.tdtmChart:
        return ScreenHandler().getTDTMReportHeader();
      case Screens.govtLab:
        return ScreenHandler().getGovernmentLabHeader();
      case Screens.hotspotZoneWise:
        return ScreenHandler().getHotspotZoneWiseHeader();
      case Screens.tdtmAdmin:
        return ScreenHandler().getTDTMAdminHeader();
      case Screens.teamWiseRevenue:
        return ScreenHandler().getTeanWiseRevenueHeader();
      case Screens.rmPickupSummaryReport:
        return ScreenHandler().getRMPickupSummaryHeader();
      case Screens.rmWiseBookingCollectionReport:
        return ScreenHandler().getRMWiseBookingCollectionHeader();
      case Screens.deptCollectionReport:
        return ScreenHandler().getDEPTCollecctionHeader();
      case Screens.inboundConversionReport:
        return ScreenHandler().getInboundConversionHeader();
      case Screens.zoneWiseCollectionReport:
        return ScreenHandler().getZoneWiseCollectionHeader();
      case Screens.rmAttendanceReport:
        return ScreenHandler().getRMAttendanceHeader();
      case Screens.projectionReport:
        return ScreenHandler().getProjectionHeader();
      case Screens.dispositionReport:
        return ScreenHandler().getDispositionHeader();
      // case Screens.phleboAttendancePickup:
      //   return ScreenHandler().getPhleboAttendancePickupHeader();

      default:
        return Container();
    }
  }

  Widget getLoader() {
    return Center(
      child: Image.asset(
        "assets/loader.gif",
        width: 128,
        height: 128,
      ),
    );
  }

  Widget getReportTitle() {
    String title = "";

    switch (widget.reportToOpen) {
      case Screens.verifier:
        title = ScreenNames.verifierReport;
        break;
      case Screens.inbound:
        title = ScreenNames.inboundLeadFlow;
        break;
      case Screens.hotspot:
        title = ScreenNames.hotspotLeadFlow;
        break;
      case Screens.agentPickup:
        title = ScreenNames.agentPickupStatus;
        break;
      case Screens.leadWiseCon:
        title = ScreenNames.leadWiseConversion;
        break;
      case Screens.performance:
        title = ScreenNames.performanceOfTheDay;
        break;
      case Screens.corporate:
        title = ScreenNames.corporateReport;
        break;
      case Screens.rmCollection:
        title = ScreenNames.rmCollectionReport;
        break;
      case Screens.tdtmChart:
        title = ScreenNames.tdtm;
        break;
      case Screens.govtLab:
        title = ScreenNames.govtLabReport;
        break;
      case Screens.hotspotZoneWise:
        title = ScreenNames.hotspotZoneWiseReport;
        break;
      case Screens.inboundTodayStatus:
        title = ScreenNames.inboundTodayStatusReport;
        break;
      case Screens.routeTracking:
        title = ScreenNames.routeTrackingReport;
        break;
      case Screens.tdtmAdmin:
        title = ScreenNames.tdtmAdminReport;
        break;
      case Screens.teamWiseRevenue:
        title = ScreenNames.teamWiseRevenue;
        break;
      case Screens.phleboAttendancePickup:
        title = ScreenNames.plheboAttendancePickupReport;
        break;
      case Screens.phleboAttendanceReport:
        title = ScreenNames.plheboAttendanceReport;
        break;
      case Screens.rmPickupSummaryReport:
        title = ScreenNames.rmPickupSummaryReport;
        break;
      case Screens.rmWiseBookingCollectionReport:
        title = ScreenNames.rmWiseBookingCollectionReport;
        break;
      case Screens.deptCollectionReport:
        title = ScreenNames.deptCollectionReport;
        break;
      case Screens.inboundConversionReport:
        title = ScreenNames.inboundConversionReport;
        break;
      case Screens.zoneWiseCollectionReport:
        title = ScreenNames.zoneWiseCollectionReport;
        break;
      case Screens.rmAttendanceReport:
        title = ScreenNames.rmAttendanceReport;
        break;
      case Screens.projectionReport:
        title = ScreenNames.projectionReport;
        break;
      case Screens.dispositionReport:
        title = ScreenNames.dispositionReport;
        break;
      default:
        title = "Report";
        break;
    }

    return Text(title);
  }
}
