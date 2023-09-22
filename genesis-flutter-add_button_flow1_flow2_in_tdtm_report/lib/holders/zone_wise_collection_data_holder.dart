import 'package:management_app/ui/widgets/zone_wise_collection_header.dart';
import 'package:management_app/utils/date_utils_custom.dart';

class ZoneWiseCollectionDataHolder {
  static final ZoneWiseCollectionDataHolder _screenHandler =
      ZoneWiseCollectionDataHolder._internal();

  factory ZoneWiseCollectionDataHolder() {
    return _screenHandler;
  }

  ZoneWiseCollectionDataHolder._internal();

  String selectedDate = DateUtilsCustom.getCurrentFormmatedDate();
  String selectedTimeSlot = "15:00-16:00";

  ZoneWiseCollectionHeader? _header;

  ZoneWiseCollectionHeader getZoneWiseCollectionHeader() {
    _header ??= const ZoneWiseCollectionHeader();
    return _header!;
  }
}
