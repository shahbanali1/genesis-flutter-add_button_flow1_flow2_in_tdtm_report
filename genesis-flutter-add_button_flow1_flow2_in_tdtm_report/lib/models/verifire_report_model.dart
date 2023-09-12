import 'package:management_app/models/base_model.dart';

class VerifireReportModel extends BaseModel {
  String? center;
  String? totalCount;
  String? amount;
  String? pOINT;
  String? verifiedCount;
  String? verifiedAmount;
  String? unVerifiedCount;
  String? unverifiedAmount;
  String? sortOrder;

  VerifireReportModel.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    center = json['Center'];
    totalCount = json['TotalCount'];
    amount = json['Amount'];
    pOINT = json['POINT'];
    verifiedCount = json['VerifiedCount'];
    verifiedAmount = json['VerifiedAmount'];
    unVerifiedCount = json['UnVerifiedCount'];
    unverifiedAmount = json['UnverifiedAmount'];
    sortOrder = json['SortOrder'];
  }
}
