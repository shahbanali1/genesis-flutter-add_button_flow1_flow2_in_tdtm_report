import 'package:management_app/ui/widgets/tdtm_admin_header.dart';
import 'package:management_app/utils/date_utils_custom.dart';

class TDTMAdminScreenDataHolder {
  static final TDTMAdminScreenDataHolder _screenHandler =
      TDTMAdminScreenDataHolder._internal();

  factory TDTMAdminScreenDataHolder() {
    return _screenHandler;
  }

  TDTMAdminScreenDataHolder._internal();

  String fromDate1 = DateUtilsCustom.getFirstDateOfMonth();
  String toDate1 = DateUtilsCustom.getCurrentFormmatedDate();

  String fromDate2 = DateUtilsCustom.getSubstractedMonthDate(
      DateUtilsCustom.getFirstDateOfMonthDateTime(), 1);

  String toDate2 = DateUtilsCustom.getSubstractedMonthDate(
      DateUtilsCustom.getCurrentDateDateTime(), 1);

  String fromDate3 = DateUtilsCustom.getSubstractedMonthDate(
      DateUtilsCustom.getFirstDateOfMonthDateTime(), 2);

  String toDate3 = DateUtilsCustom.getSubstractedMonthDate(
      DateUtilsCustom.getCurrentDateDateTime(), 2);

  String fromDate4 = DateUtilsCustom.getSubstractedMonthDate(
      DateUtilsCustom.getFirstDateOfMonthDateTime(), 3);
  String toDate4 = DateUtilsCustom.getSubstractedMonthDate(
      DateUtilsCustom.getCurrentDateDateTime(), 3);

  String specialPackage = "1";

  String flowType = "0";

  TDTMAdminHeader? _tdtmAdminHeader;

  TDTMAdminHeader getTDTMAdminHeader() {
    _tdtmAdminHeader ??= const TDTMAdminHeader();
    return _tdtmAdminHeader!;
  }
}
