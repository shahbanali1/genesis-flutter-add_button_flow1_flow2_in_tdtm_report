import 'package:flutter/material.dart';
import 'package:management_app/constants/constant.dart';
import 'package:management_app/constants/screens.dart';
import 'package:management_app/constants/string.dart';

class ScreenListItem {
  const ScreenListItem(
      {required this.title, required this.routeName, required this.imageIcon});
  final String title;
  final String routeName;
  final AssetImage imageIcon;
}

const List<ScreenListItem> getListItem = <ScreenListItem>[
  ScreenListItem(
    title: Strings.verifierReport,
    routeName: Constant.verifierRoute,
    imageIcon: AssetImage('assets/ic_verify_report.png'),
  ),
  ScreenListItem(
      title: Strings.inboundLeadFlow,
      routeName: Constant.inboundRoute,
      imageIcon: AssetImage('assets/ic_inbound.png')),
  ScreenListItem(
      title: Strings.hotspotLeadFlow,
      routeName: Constant.hotspotRoute,
      imageIcon: AssetImage('assets/ic_hotspot.png')),
  ScreenListItem(
      title: Strings.agentPickupStatus,
      routeName: Constant.agentPickupRoute,
      imageIcon: AssetImage('assets/ic_agent_pickup.png')),
  ScreenListItem(
      title: Strings.leadWiseConversion,
      routeName: Constant.leadWiseRoute,
      imageIcon: AssetImage('assets/ic_lead_wise.png')),
  ScreenListItem(
      title: Strings.performanceOfTheDay,
      routeName: Constant.performanceRoute,
      imageIcon: AssetImage('assets/ic_performance.png')),
  ScreenListItem(
      title: Strings.corporateReport,
      routeName: Constant.corporateRoute,
      imageIcon: AssetImage('assets/ic_corporate.png')),
  ScreenListItem(
      title: Strings.rmCollectionReport,
      routeName: Constant.rmCollectionRoute,
      imageIcon: AssetImage('assets/ic_rm_collection.png')),
  ScreenListItem(
      title: Strings.tdtm,
      routeName: Constant.tdtmRoute,
      imageIcon: AssetImage('assets/ic_tdtm.png')),
  ScreenListItem(
      title: Strings.tdtmAdmin,
      routeName: Constant.tdtmAdminRoute,
      imageIcon: AssetImage('assets/ic_tdtm.png')),
  ScreenListItem(
      title: Strings.govtLab,
      routeName: Constant.govtLabRoute,
      imageIcon: AssetImage('assets/ic_govt_lab.png')),
  ScreenListItem(
      title: Strings.hotspotZoneWise,
      routeName: Constant.hotspotZoneWise,
      imageIcon: AssetImage('assets/ic_hotspot_zonewise.png')),
  ScreenListItem(
      title: Strings.inboundTodayStatus,
      routeName: Constant.inboundTodayStatus,
      imageIcon: AssetImage('assets/ic_inbound_todaystatus.png')),
//This Report is hides now as per client requirement (Anish Sir)
  // ScreenListItem(
  //     title: Strings.routeTracking,
  //     routeName: Constant.routeTracking,
  //     imageIcon: AssetImage('assets/ic_tracking.png')),

  ScreenListItem(
      title: Strings.teamWiseRevenue,
      routeName: Constant.teamWiseRevenueRoute,
      imageIcon: AssetImage('assets/ic_team_wise_revenue.png')),

  //This Report is hides now as per client requirement (Anish Sir)
  // ScreenListItem(
  //     title: Strings.plheboAttendancePickup,
  //     routeName: Constant.phleboAttendancePickupRoute,
  //     imageIcon: AssetImage('assets/ic_phlebo_attendance_pickup.png')),

  //This Report is hides now as per client requirement (Anish Sir)
  // ScreenListItem(
  //     title: Strings.plheboAttendanceReport,
  //     routeName: Constant.phleboAttendanceReportRoute,
  //     imageIcon: AssetImage('assets/ic_phlebo_attendance_pickup.png')),

  ScreenListItem(
      title: ScreenNames.rmPickupSummaryReport,
      routeName: Constant.rmPickUpSummaryReportRoute,
      imageIcon: AssetImage('assets/ic_phlebo_attendance_pickup.png')),

  ScreenListItem(
      title: ScreenNames.rmWiseBookingCollectionReport,
      routeName: Constant.rmWiseBookingCollectionReportRoute,
      imageIcon: AssetImage('assets/ic_phlebo_attendance_pickup.png')),

  ScreenListItem(
      title: ScreenNames.deptCollectionReport,
      routeName: Constant.deptCollectionReportRoute,
      imageIcon: AssetImage('assets/ic_rm_collection.png')),

  ScreenListItem(
      title: ScreenNames.inboundConversionReport,
      routeName: Constant.inboundConversionReportRoute,
      imageIcon: AssetImage('assets/ic_team_wise_revenue.png')),

  ScreenListItem(
      title: ScreenNames.masterPin,
      routeName: Constant.masterPinRoute,
      imageIcon: AssetImage('assets/ic_phlebo_attendance_pickup.png')),

  ScreenListItem(
      title: ScreenNames.zoneWiseCollectionReport,
      routeName: Constant.zoneWiseCollectionReportRoute,
      imageIcon: AssetImage('assets/ic_phlebo_attendance_pickup.png')),

  ScreenListItem(
      title: ScreenNames.rmAttendanceReport,
      routeName: Constant.rmAttendanceReportRoute,
      imageIcon: AssetImage('assets/ic_attendance.png')),

  // ScreenListItem(
  //     title: Strings.logout,
  //     routeName: Constant.logoutRoute,
  //     imageIcon: AssetImage('assets/ic_tdtm.png')),
];
