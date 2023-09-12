import 'package:management_app/ui/widgets/government_lab_header.dart';
import 'package:management_app/utils/date_utils_custom.dart';

class GovernmentLabScreenDateHolder {
  static final GovernmentLabScreenDateHolder _screenDateHolder =
      GovernmentLabScreenDateHolder._internal();

  factory GovernmentLabScreenDateHolder() {
    return _screenDateHolder;
  }

  GovernmentLabScreenDateHolder._internal();

  String fromDate = DateUtilsCustom.getYesterdayFormmatedDate();
  String toDate = DateUtilsCustom.getCurrentFormmatedDate();

  GovernmentLabHeader? _governmentLabHeader;

  GovernmentLabHeader getGovernmentLabHeader() {
    _governmentLabHeader ??= GovernmentLabHeader();
    return _governmentLabHeader!;
  }
}
