import 'package:management_app/ui/widgets/inbount_conversion_header.dart';
import 'package:management_app/utils/date_utils_custom.dart';

class InboundConversionDateHolder {
  static final InboundConversionDateHolder _screenHandler =
      InboundConversionDateHolder._internal();

  factory InboundConversionDateHolder() {
    return _screenHandler;
  }

  InboundConversionDateHolder._internal();

  String selectedDate = DateUtilsCustom.getCurrentFormmatedDate();

  InboundConversionHeader? _inboundConversionHeader;

  InboundConversionHeader getInboundConversionHeader() {
    _inboundConversionHeader ??= const InboundConversionHeader();
    return _inboundConversionHeader!;
  }
}
