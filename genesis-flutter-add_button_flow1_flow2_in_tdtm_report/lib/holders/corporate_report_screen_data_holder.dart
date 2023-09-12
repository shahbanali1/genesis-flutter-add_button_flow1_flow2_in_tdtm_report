import 'package:management_app/ui/widgets/corporate_header.dart';
import 'package:management_app/utils/date_utils_custom.dart';

class CorporateReportScreenDataHolder {
  static final CorporateReportScreenDataHolder _screenHandler =
      CorporateReportScreenDataHolder._internal();

  factory CorporateReportScreenDataHolder() {
    return _screenHandler;
  }

  CorporateReportScreenDataHolder._internal();

  String date = DateUtilsCustom.getCurrentFormmatedDate();

  CorporateHeader? _header;

  CorporateHeader getCorporateReportHeader() {
    _header ??= const CorporateHeader();
    return _header!;
  }

  // String getReportDate() {
  //   return DateUtils.getCurrentFormmatedDate("MM-dd-yyyy");
  // }
}
