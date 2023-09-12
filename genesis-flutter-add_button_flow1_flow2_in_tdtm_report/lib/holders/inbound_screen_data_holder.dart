import 'package:management_app/ui/widgets/inbound_header.dart';

class InboundScreenDataHolder {
  static final InboundScreenDataHolder _screenHandler =
      InboundScreenDataHolder._internal();

  factory InboundScreenDataHolder() {
    return _screenHandler;
  }

  InboundScreenDataHolder._internal();

  String defaultMonth = 'January';
  String defaultTimeSlot = '09:00-10:00';

  InboundHeader? _inboundHeader;

  InboundHeader getInboundHeader() {
    _inboundHeader ??= const InboundHeader();
    return _inboundHeader!;
  }
}
