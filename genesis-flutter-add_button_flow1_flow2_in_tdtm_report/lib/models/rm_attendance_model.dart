class RMAttendanceModel {
  String? logindate;
  String? rMName;
  String? logintime;

  RMAttendanceModel({this.logindate, this.rMName, this.logintime});

  RMAttendanceModel.fromJson(Map<String, dynamic> json) {
    logindate = json['logindate'];
    rMName = json['RMName'];
    logintime = json['logintime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logindate'] = this.logindate;
    data['RMName'] = this.rMName;
    data['logintime'] = this.logintime;
    return data;
  }
}
