import 'package:management_app/ui/widgets/rm_pickup_summary_header.dart';
import 'package:management_app/utils/date_utils_custom.dart';

class RMPickupSummaryScreenDataHolder {
  static final RMPickupSummaryScreenDataHolder _screenHandler =
      RMPickupSummaryScreenDataHolder._internal();

  factory RMPickupSummaryScreenDataHolder() {
    return _screenHandler;
  }

  RMPickupSummaryScreenDataHolder._internal();

  String fromDate = DateUtilsCustom.getCurrentFormmatedDate();
  String toDate = DateUtilsCustom.getCurrentFormmatedDate();

  String selectedTimeSlot = '09:00-10:00';

  RMPickupSummaryHeader? _rmPickupSummaryReportHeader;

  RMPickupSummaryHeader getRMPickupSummaryHeader() {
    _rmPickupSummaryReportHeader = RMPickupSummaryHeader();
    return _rmPickupSummaryReportHeader!;
  }
}
