import 'package:management_app/ui/widgets/verifire_header.dart';
import 'package:management_app/utils/date_utils_custom.dart';

class VerifierScreenDataHolder {
  static final VerifierScreenDataHolder _screenHandler =
      VerifierScreenDataHolder._internal();

  factory VerifierScreenDataHolder() {
    return _screenHandler;
  }

  VerifierScreenDataHolder._internal();

  String dayType = "0"; //0 -Today, 1-Tomorrow
  String flowType = "0"; //0 -All, 1-Flow1, 2-Flow2
  String date = DateUtilsCustom.getCurrentFormmatedDate();

  VerifireHeader? _verifireHeader;

  VerifireHeader getVerifierHeader() {
    _verifireHeader ??= const VerifireHeader();
    return _verifireHeader!;
  }

  String getReportDate() {
    return DateUtilsCustom.getCurrentFormmatedDate();
  }
}
