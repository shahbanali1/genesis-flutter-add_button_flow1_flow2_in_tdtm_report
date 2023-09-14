class OTPVerifyModel {
  String? runnerID;
  String? jobRole;
  String? appCode;

  OTPVerifyModel({this.runnerID, this.jobRole, this.appCode});

  OTPVerifyModel.fromJson(Map<String, dynamic> json) {
    runnerID = json['runnerID'];
    jobRole = json['jobRole'];
    appCode = json['appCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['runnerID'] = this.runnerID;
    data['jobRole'] = this.jobRole;
    data['appCode'] = this.appCode;
    return data;
  }
}
