import 'package:management_app/ui/widgets/lead_wise_conversion_header.dart';
import 'package:management_app/utils/date_utils_custom.dart';

class LeadWiseConversionScreenDataHolder {
  static final LeadWiseConversionScreenDataHolder _screenHandler =
      LeadWiseConversionScreenDataHolder._internal();

  factory LeadWiseConversionScreenDataHolder() {
    return _screenHandler;
  }

  LeadWiseConversionScreenDataHolder._internal();

  String leadDate = DateUtilsCustom.getCurrentFormmatedDate();

  LeadWiseConversionHeader? _header;

  LeadWiseConversionHeader getLeadWiseConversionHeader() {
    _header ??= const LeadWiseConversionHeader();
    return _header!;
  }
}
