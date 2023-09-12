import 'package:management_app/ui/widgets/tdtm_header.dart';
import 'package:management_app/utils/date_utils_custom.dart';

class TDTMScreenDataHolder {
  static final TDTMScreenDataHolder _screenHandler =
      TDTMScreenDataHolder._internal();

  factory TDTMScreenDataHolder() {
    return _screenHandler;
  }

  TDTMScreenDataHolder._internal();

  // String fromDate1 = DateUtilsCustom.getCurrentFormmatedDate();
  // String toDate1 = DateUtilsCustom.getCurrentFormmatedDate();

  // String fromDate2 = DateUtilsCustom.getCurrentFormmatedDate();
  // String toDate2 = DateUtilsCustom.getCurrentFormmatedDate();

  // String fromDate3 = DateUtilsCustom.getCurrentFormmatedDate();
  // String toDate3 = DateUtilsCustom.getCurrentFormmatedDate();

  // String fromDate4 = DateUtilsCustom.getCurrentFormmatedDate();
  // String toDate4 = DateUtilsCustom.getCurrentFormmatedDate();

  //getCurrentDateDateTime

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

  TDTMHeader? _tdtmHeader;

  TDTMHeader getTDTMHeader() {
    _tdtmHeader ??= const TDTMHeader();
    return _tdtmHeader!;
  }
}
