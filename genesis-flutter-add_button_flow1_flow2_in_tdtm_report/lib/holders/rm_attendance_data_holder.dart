import 'package:management_app/ui/widgets/rm_attendance_header.dart';
import 'package:management_app/utils/date_utils_custom.dart';

class RmAttendanceDateHolder {
  static final RmAttendanceDateHolder _screenHandler =
      RmAttendanceDateHolder._internal();

  factory RmAttendanceDateHolder() {
    return _screenHandler;
  }

  RmAttendanceDateHolder._internal();

  String fromDate = DateUtilsCustom.getCurrentFormmatedDate();
  String toDate = DateUtilsCustom.getCurrentFormmatedDate();
  String type = '0';

  RMAttendanceHeader? _rmattendanceHeader;

  RMAttendanceHeader getRMAttendanceHeader() {
    _rmattendanceHeader ??= const RMAttendanceHeader();
    return _rmattendanceHeader!;
  }
}


// class RMAttendanceDataHolder {
//   static final RMAttendanceDataHolder _screenHandler =
//       RMAttendanceDataHolder._internal();

//   factory RMAttendanceDataHolder() {
//     return _screenHandler;
//   }

//   RMAttendanceDataHolder._internal();

//   String fromDate = DateUtilsCustom.getCurrentFormmatedDate();
//   String toDate = DateUtilsCustom.getCurrentFormmatedDate();

//   RMAttendanceHeader? _rmAttendanceHeader;

//   RMAttendanceHeader? getRMAttendanceHeader() {
//     _rmAttendanceHeader ??= const RMAttendanceHeader();
//     return _rmAttendanceHeader;
//   }
// }
