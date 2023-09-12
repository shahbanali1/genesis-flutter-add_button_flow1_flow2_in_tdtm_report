class OTPVerifyModel {
  String? runnerID;
  String? jobRole;

  OTPVerifyModel({this.runnerID, this.jobRole});

  OTPVerifyModel.fromJson(Map<String, dynamic> json) {
    runnerID = json['runnerID'];
    jobRole = json['jobRole'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['runnerID'] = this.runnerID;
    data['jobRole'] = this.jobRole;
    return data;
  }
}
