class RMAttendanceModel {
  String? logindate;
  String? logintime;
  String? rMName;

  RMAttendanceModel({
    this.logindate,
    this.logintime,
    this.rMName,
  });

  RMAttendanceModel.fromJson(Map<String, dynamic> json) {
    logindate = json['logindate'];
    logintime = json['logintime'];
    rMName = json['RMName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logindate'] = this.logindate;
    data['logintime'] = this.logintime;
    data['RMName'] = this.rMName;
    return data;
  }
}
