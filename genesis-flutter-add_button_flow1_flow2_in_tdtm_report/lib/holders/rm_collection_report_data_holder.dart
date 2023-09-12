import 'package:management_app/ui/widgets/rm_collection_header.dart';
import 'package:management_app/utils/date_utils_custom.dart';

class RMCollectionReportDateHolder {
  static final RMCollectionReportDateHolder _screenHandler =
      RMCollectionReportDateHolder._internal();

  factory RMCollectionReportDateHolder() {
    return _screenHandler;
  }

  RMCollectionReportDateHolder._internal();

  String fromDate = DateUtilsCustom.getCurrentFormmatedDate();
  String toDate = DateUtilsCustom.getCurrentFormmatedDate();
  String type = '0';

  RmCollectionHeader? _rmCollectionHeader;

  RmCollectionHeader getRMCollecctionHeader() {
    _rmCollectionHeader ??= const RmCollectionHeader();
    return _rmCollectionHeader!;
  }

  // String getReportDate() {
  //   return DateUtils.getCurrentFormmatedDate("MM-dd-yyyy");
  // }
}
