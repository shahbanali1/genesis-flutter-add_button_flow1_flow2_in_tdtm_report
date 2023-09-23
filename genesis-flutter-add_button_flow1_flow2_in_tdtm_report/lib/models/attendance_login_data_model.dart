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
