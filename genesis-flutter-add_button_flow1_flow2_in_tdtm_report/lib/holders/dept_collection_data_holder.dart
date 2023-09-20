import 'package:management_app/ui/widgets/dept_collection_header.dart';
import 'package:management_app/utils/date_utils_custom.dart';

class DEPTCollectionDateHolder {
  static final DEPTCollectionDateHolder _screenHandler =
      DEPTCollectionDateHolder._internal();

  factory DEPTCollectionDateHolder() {
    return _screenHandler;
  }

  DEPTCollectionDateHolder._internal();

  String fromDate = DateUtilsCustom.getCurrentFormmatedDate();
  String toDate = DateUtilsCustom.getCurrentFormmatedDate();
  String type = '1';

  DEPTCollectionHeader? _deptCollectionHeader;

  DEPTCollectionHeader getDEPTCollecctionHeader() {
    _deptCollectionHeader ??= const DEPTCollectionHeader();
    return _deptCollectionHeader!;
  }
}
