class TDTMModel {
  String teamSeq = "";
  String center = "";
  String date1 = "";
  String date2 = "";
  String date3 = "";
  String date4 = "";

  TDTMModel(
      {required this.teamSeq,
      required this.center,
      required this.date1,
      required this.date2,
      required this.date3,
      required this.date4});

  TDTMModel.fromJson(Map<String, dynamic> json) {
    teamSeq = json['TeamSeq'] ?? "";
    center = json['Center'] ?? "";
    date1 = json['Date1'] ?? "";
    date2 = json['Date2'] ?? "";
    date3 = json['Date3'] ?? "";
    date4 = json['Date4'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TeamSeq'] = this.teamSeq;
    data['Center'] = this.center;
    data['Date1'] = this.date1;
    data['Date2'] = this.date2;
    data['Date3'] = this.date3;
    data['Date4'] = this.date4;
    return data;
  }
}
