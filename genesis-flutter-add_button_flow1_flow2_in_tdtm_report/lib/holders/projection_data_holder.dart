import 'package:management_app/ui/widgets/projection_header.dart';
import 'package:management_app/utils/date_utils_custom.dart';

class ProjectionDataHolder {
  static final ProjectionDataHolder _singleton =
      ProjectionDataHolder._internal();

  factory ProjectionDataHolder() {
    return _singleton;
  }

  ProjectionDataHolder._internal();

  String fromDate = DateUtilsCustom.getFirstDateOfMonth();
  String toDate = DateUtilsCustom.getCurrentFormmatedDate();

  String specialPackage = "0";

  ProjectionHeader? _projectionHeader;
  ProjectionHeader getProjectionHeader() {
    _projectionHeader ??= const ProjectionHeader();
    return _projectionHeader!;
  }
}
