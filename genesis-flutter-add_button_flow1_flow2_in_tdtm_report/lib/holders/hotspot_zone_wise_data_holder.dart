import 'package:management_app/ui/widgets/hotspot_zone_wise_header.dart';
import 'package:management_app/utils/date_utils_custom.dart';

class HotspotZoneWiseScreenDataHolder {
  static final HotspotZoneWiseScreenDataHolder _screenHandler =
      HotspotZoneWiseScreenDataHolder._internal();

  factory HotspotZoneWiseScreenDataHolder() {
    return _screenHandler;
  }

  HotspotZoneWiseScreenDataHolder._internal();

  String selectedDate = DateUtilsCustom.getCurrentFormmatedDate();

  HotSpotZoneWiseHeader? _header;

  HotSpotZoneWiseHeader getHotspotZoneWiseHeader() {
    _header ??= const HotSpotZoneWiseHeader();
    return _header!;
  }
}
