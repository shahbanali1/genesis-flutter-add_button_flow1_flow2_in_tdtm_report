import 'package:management_app/models/attendance_login_data_model.dart';

class AttenadnceReportModel {
  String? loginDate;
  List<Logins>? logins;

  AttenadnceReportModel({this.loginDate, this.logins});

  AttenadnceReportModel.fromJson(Map<String, dynamic> json) {
    loginDate = json['loginDate'];
    if (json['logins'] != null) {
      logins = <Logins>[];
      json['logins'].forEach((v) {
        logins!.add(new Logins.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loginDate'] = this.loginDate;
    if (this.logins != null) {
      data['logins'] = this.logins!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
