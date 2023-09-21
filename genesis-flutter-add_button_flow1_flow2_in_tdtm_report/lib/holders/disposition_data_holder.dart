import 'package:management_app/ui/widgets/disposition_header.dart';
import 'package:management_app/utils/date_utils_custom.dart';

class DispositionDataHolder {
  static final DispositionDataHolder _singleton =
      DispositionDataHolder._internal();

  factory DispositionDataHolder() {
    return _singleton;
  }

  DispositionDataHolder._internal();

  String fromDate = DateUtilsCustom.getCurrentFormmatedDate();
  String toDate = DateUtilsCustom.getCurrentFormmatedDate();

  String dispoType = "0";

  DispositionHeader? _dispositionHeader;
  DispositionHeader getDispositionHeader() {
    _dispositionHeader ??= const DispositionHeader();
    return _dispositionHeader!;
  }
}
