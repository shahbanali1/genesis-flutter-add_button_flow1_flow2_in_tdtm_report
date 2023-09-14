import 'package:management_app/ui/widgets/team_wise_revenue_header.dart';
import 'package:management_app/utils/date_utils_custom.dart';

class TeamWiseRevenueScreenDataHolder {
  static final TeamWiseRevenueScreenDataHolder _screenHandler =
      TeamWiseRevenueScreenDataHolder._internal();

  factory TeamWiseRevenueScreenDataHolder() {
    return _screenHandler;
  }

  TeamWiseRevenueScreenDataHolder._internal();

  String fromDate = DateUtilsCustom.getFirstDateOfMonth();
  String toDate = DateUtilsCustom.getCurrentFormmatedDate();

  String specialPackage = "1";

  TeamWiseRevenueHeader? _teamWiseRevenueHeader;

  TeamWiseRevenueHeader getTeamWiseRevenueHeader() {
    _teamWiseRevenueHeader ??= const TeamWiseRevenueHeader();
    return _teamWiseRevenueHeader!;
  }
}
