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

class Logins {
  String? rMName;
  String? loginTime;

  Logins({this.rMName, this.loginTime});

  Logins.fromJson(Map<String, dynamic> json) {
    rMName = json['RMName'];
    loginTime = json['loginTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RMName'] = this.rMName;
    data['loginTime'] = this.loginTime;
    return data;
  }
}
