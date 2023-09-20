import 'package:management_app/ui/widgets/rm_wise_booking_collection_header.dart';
import 'package:management_app/utils/date_utils_custom.dart';

class RMWiseBookingCollectionDataHolder {
  static final RMWiseBookingCollectionDataHolder _screenHandler =
      RMWiseBookingCollectionDataHolder._internal();

  factory RMWiseBookingCollectionDataHolder() {
    return _screenHandler;
  }

  RMWiseBookingCollectionDataHolder._internal();

  String fromDate = DateUtilsCustom.getCurrentFormmatedDate();

  RMWiseBookingCollectionHeader? _rmWiseBookingCollectionReportHeader;

  RMWiseBookingCollectionHeader getRMWiseBookingCollectionHeader() {
    _rmWiseBookingCollectionReportHeader = RMWiseBookingCollectionHeader();
    return _rmWiseBookingCollectionReportHeader!;
  }
}
