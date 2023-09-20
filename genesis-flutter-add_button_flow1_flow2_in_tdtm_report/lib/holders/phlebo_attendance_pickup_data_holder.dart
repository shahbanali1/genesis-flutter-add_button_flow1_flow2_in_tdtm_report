import 'package:management_app/ui/widgets/phlebo_attendance_pickup_header.dart';
import 'package:management_app/utils/date_utils_custom.dart';

class PhleboAttendancePickupScreenDataHolder {
  static final PhleboAttendancePickupScreenDataHolder _screenHandler =
      PhleboAttendancePickupScreenDataHolder._internal();

  factory PhleboAttendancePickupScreenDataHolder() {
    return _screenHandler;
  }

  PhleboAttendancePickupScreenDataHolder._internal();

  String searchDate = DateUtilsCustom.getCurrentFormmatedDate();
  String selectedRM = "All";

  PhleboAttendancePickupHeader? _phleboAttendancePickupHeader;

  PhleboAttendancePickupHeader getPhleboAttendancePickupHeader(
      List<String> rmList, String selectedRM, String dataRowSize) {
    _phleboAttendancePickupHeader = PhleboAttendancePickupHeader(
      rmList: rmList,
      selectedRM: selectedRM,
      dataRowSize: dataRowSize,
    );
    return _phleboAttendancePickupHeader!;
  }
}
