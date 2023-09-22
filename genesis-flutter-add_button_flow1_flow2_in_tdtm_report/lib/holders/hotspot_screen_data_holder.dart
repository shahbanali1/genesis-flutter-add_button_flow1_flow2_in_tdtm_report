import 'package:management_app/ui/widgets/hot_spot_header.dart';

class HotSpotScreenDataHolder {
  static final HotSpotScreenDataHolder _screenHandler =
      HotSpotScreenDataHolder._internal();

  factory HotSpotScreenDataHolder() {
    return _screenHandler;
  }

  HotSpotScreenDataHolder._internal();

  String month = 'November';
  String timeSlot = '11:00-12:00';
  String reportType = "0"; //0- All, 1-Hotspot, 2- Justdail

  HotSpotHeader? _header;

  HotSpotHeader getHotSpotHeader() {
    _header ??= const HotSpotHeader();
    return _header!;
  }

  // String getReportDate() {
  //   return DateUtils.getCurrentFormmatedDate("MM-dd-yyyy");
  // }
}
