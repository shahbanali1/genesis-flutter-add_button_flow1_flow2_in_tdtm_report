import 'package:management_app/ui/widgets/agent_pickup_header.dart';
import 'package:management_app/utils/date_utils_custom.dart';

class AgentPickupScreenDataHolder {
  static final AgentPickupScreenDataHolder _screenHandler =
      AgentPickupScreenDataHolder._internal();

  factory AgentPickupScreenDataHolder() {
    return _screenHandler;
  }

  AgentPickupScreenDataHolder._internal();

  String date = DateUtilsCustom.getCurrentFormmatedDate();
  String userRole = 'HM';
  String location = 'Gurgoan';

  AgentPickupHeader? _header;

  AgentPickupHeader getAgentPickupHeader() {
    _header ??= const AgentPickupHeader();
    return _header!;
  }

  // String getReportDate() {
  //   return DateUtils.getCurrentFormmatedDate("MM-dd-yyyy");
  // }
}
