import 'package:flutter/material.dart';
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
import 'package:management_app/utils/common_utils.dart';
import 'package:management_app/utils/date_utils_custom.dart';
import 'package:management_app/utils/management_apis.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenHandler {
  static final ScreenHandler _screenHandler = ScreenHandler._internal();

  factory ScreenHandler() {
    return _screenHandler;
  }

  ScreenHandler._internal();

  ManagementApis managementApis = ManagementApis();
  CommonUtils commonUtils = CommonUtils();

  Future<List<BaseModel>> getVerifireReport(String dayType, String flowType) {
    return managementApis.getVerifireReport(
        dayType,
        VerifierScreenDataHolder().date,
        commonUtils.checkPlatformType(),
        flowType);
  }

  Widget getVerfierHeader() {
    return VerifierScreenDataHolder().getVerifierHeader();
  }

  Future<List<BaseModel>> getInboundReportData(
      String selectedMonth, String selectedTimeSlot) {
    return managementApis.getInboundReport(
        selectedMonth, selectedTimeSlot, commonUtils.checkPlatformType());
  }

  Widget getInboundHeader() {
    return InboundScreenDataHolder().getInboundHeader();
  }

  Widget getHotSpotHeader() {
    return HotSpotScreenDataHolder().getHotSpotHeader();
  }

  Future<List<BaseModel>> getHotspotReportData(
      String selectedType, String selectedMonth, String selectedTimeSlot) {
    return managementApis.getHotSpotReport(selectedMonth, selectedTimeSlot,
        selectedType, commonUtils.checkPlatformType());
  }

  Widget getAgentPickupHeader() {
    return AgentPickupScreenDataHolder().getAgentPickupHeader();
  }

  Future<List<BaseModel>> getAgentPickupReportData(
      String date, String userRole, String location) {
    return managementApis.getAgentPickupReport(
        date, userRole, location, commonUtils.checkPlatformType());
  }

  Widget getLeadWiseConversionHeader() {
    return LeadWiseConversionScreenDataHolder().getLeadWiseConversionHeader();
  }

  Future<List<BaseModel>> getLeadWiseConversionData(String selectedDate) {
    return managementApis.getLeadWiseConversionReport(
        selectedDate, commonUtils.checkPlatformType());
  }

  Widget getPerformanceOfTheDayHeader() {
    return PerformanceOfTheDayDataHolder().getPerformanceOfTheDayHeader();
  }

  Future<List<BaseModel>> getPerformanceOfTheDayData(
      String process, String location, String count) {
    return managementApis.getPerformanceOfTheDayReport(
        process, location, count, commonUtils.checkPlatformType());
  }

  Widget getCorporateReportHeader() {
    return CorporateReportScreenDataHolder().getCorporateReportHeader();
  }

  Future<List<BaseModel>> getCorporateReportData(String selectedDate) {
    return ManagementApis()
        .getCorporateReport(selectedDate, commonUtils.checkPlatformType());
  }

  Widget getRMCollecctionReportHeader() {
    return RMCollectionReportDateHolder().getRMCollecctionHeader();
  }

  Future<List<BaseModel>> getRMCollectionReportData(
      String selectedFromDate, String selectedToDate) {
    return ManagementApis().getRMCollectionReport(
        selectedFromDate,
        selectedToDate,
        RMCollectionReportDateHolder().type,
        commonUtils.checkPlatformType());
  }

  Widget getTDTMReportHeader() {
    return TDTMScreenDataHolder().getTDTMHeader();
  }

  Future<List<BaseModel>> getTDTMReportData(
    String selectedFromDate1,
    String selectedToDate1,
    String FromDate2,
    String ToDate2,
    String FromDate3,
    String ToDate3,
    String FromDate4,
    String ToDate4,
    String FlowType,
  ) {
    return ManagementApis().getTDTMReport(
        selectedFromDate1,
        selectedToDate1,
        FromDate2,
        ToDate2,
        FromDate3,
        ToDate3,
        FromDate4,
        ToDate4,
        FlowType,
        TDTMScreenDataHolder().specialPackage,
        commonUtils.checkPlatformType());
  }

  Widget getGovernmentLabHeader() {
    return GovernmentLabScreenDateHolder().getGovernmentLabHeader();
  }

  Future<List<BaseModel>> getGovernmentLabReportData(
      String selectedFromDate, String selectedToDate) {
    return ManagementApis().getgovtLaReport(
        selectedFromDate, selectedToDate, commonUtils.checkPlatformType());
  }

  Widget getHotspotZoneWiseHeader() {
    return HotspotZoneWiseScreenDataHolder().getHotspotZoneWiseHeader();
  }

  Future<List<BaseModel>> getHotspotZoneWiseReportData(String selectedDate) {
    return managementApis.getHotspotZoneWiseReport(
        selectedDate, commonUtils.checkPlatformType());
  }

  Future<List<BaseModel>> getInboundTodayStatusReportData() {
    return managementApis.getInboundTodayStatusReport(
        DateUtilsCustom.getCurrentFormmatedDate(),
        commonUtils.checkPlatformType());
  }

  Future<List<BaseModel>> getRouteTrackingReportData() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    return managementApis.getGetRouteTrackingReport(
        prefs.getString("user_id").toString(), commonUtils.checkPlatformType());
  }

  Widget getTDTMAdminHeader() {
    return TDTMAdminScreenDataHolder().getTDTMAdminHeader();
  }

  Future<List<BaseModel>> getTDTMAdminReportData(
    String selectedFromDate1,
    String selectedToDate1,
    String FromDate2,
    String ToDate2,
    String FromDate3,
    String ToDate3,
    String FromDate4,
    String ToDate4,
    String FlowType,
  ) {
    return managementApis.getTDTMReport(
        selectedFromDate1,
        selectedToDate1,
        FromDate2,
        ToDate2,
        FromDate3,
        ToDate3,
        FromDate4,
        ToDate4,
        FlowType,
        TDTMAdminScreenDataHolder().specialPackage,
        commonUtils.checkPlatformType());
  }

  Widget getTeanWiseRevenueHeader() {
    return TeamWiseRevenueScreenDataHolder().getTeamWiseRevenueHeader();
  }

  Future<List<BaseModel>> getTeamWiseRevenueReportData(
      String fromDate, String toDate) {
    return managementApis.getTeamWiseRevenueReport(
        fromDate,
        toDate,
        TeamWiseRevenueScreenDataHolder().specialPackage,
        commonUtils.checkPlatformType());
  }

  Widget getPhleboAttendancePickupHeader(
      List<String> listUniqueRM, String rm, String dataRowSize) {
    return PhleboAttendancePickupScreenDataHolder()
        .getPhleboAttendancePickupHeader(listUniqueRM, rm, dataRowSize);
  }

  Future<List<BaseModel>> getPhleboAttendancePickupReportData(
      String selectedRM) {
    return managementApis.getPhleboAttendancePickupReport(
        selectedRM,
        PhleboAttendancePickupScreenDataHolder().searchDate,
        commonUtils.checkPlatformType());
  }

  Widget getRMPickupSummaryHeader() {
    return RMPickupSummaryScreenDataHolder().getRMPickupSummaryHeader();
  }

  Future<List<BaseModel>> getRMPickupSummaryReportData(
      String selectedFromDate, String selectedToDate) {
    return managementApis.getRMPickupSummaryReport(
        selectedFromDate, selectedToDate, commonUtils.checkPlatformType());
  }

  Widget getRMWiseBookingCollectionHeader() {
    return RMWiseBookingCollectionDataHolder()
        .getRMWiseBookingCollectionHeader();
  }

  Future<List<BaseModel>> getRMWiseBookingCollectionReportData(
      String selectedDate, selectedTime) {
    return managementApis.getRMWiseBookingCollectionReport(
        selectedDate, selectedTime, commonUtils.checkPlatformType());
  }

  Widget getDEPTCollecctionHeader() {
    return DEPTCollectionDateHolder().getDEPTCollecctionHeader();
  }

  Future<List<BaseModel>> getDEPTCollectionReportData(
      String selectedFromDate, String selectedToDate) {
    return managementApis.getRMCollectionReport(
        selectedFromDate,
        selectedToDate,
        DEPTCollectionDateHolder().type,
        commonUtils.checkPlatformType());
  }

  Widget getInboundConversionHeader() {
    return InboundConversionDateHolder().getInboundConversionHeader();
  }

  Future<List<BaseModel>> getInboundConversionReportData(String selectedDate) {
    return managementApis.getInboundConversionReport(
        selectedDate, commonUtils.checkPlatformType());
  }

  Widget getZoneWiseCollectionHeader() {
    return ZoneWiseCollectionDataHolder().getZoneWiseCollectionHeader();
  }

  Future<List<BaseModel>> getZoneWiseCollectionReportData(
      String selectedDate, String selectedTime) {
    return managementApis.getZoneWiseBookingCollection(
        selectedDate, selectedTime, commonUtils.checkPlatformType());
  }

  Widget getRMAttendanceHeader() {
    return RmAttendanceDateHolder().getRMAttendanceHeader();
  }

  Future<List<BaseModel>> getRMAttendanceReportData(
      String selectedFromDate, String selectedToDate) {
    return managementApis.getRmAttendanceReport(
        selectedFromDate, selectedToDate, commonUtils.checkPlatformType());
  }

  Widget getProjectionHeader() {
    return ProjectionDataHolder().getProjectionHeader();
  }

  Future<List<BaseModel>> getProjectionReportData(
      String fromDate, String toDate, String specialPackage) {
    return managementApis.getTeamWiseRevenueReport(
        fromDate, toDate, specialPackage, commonUtils.checkPlatformType());
  }

  Widget getDispositionHeader() {
    return DispositionDataHolder().getDispositionHeader();
  }

  Future<List<BaseModel>> getDispositionReportData(
    String fromDate,
    String toDate,
  ) {
    return managementApis.getDispositionReport(fromDate, toDate,
        DispositionDataHolder().dispoType, commonUtils.checkPlatformType());
  }
}
