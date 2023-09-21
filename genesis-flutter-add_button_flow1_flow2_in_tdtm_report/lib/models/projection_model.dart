class ProjectionModel {
  String TeamSeq = "";
  String TeamLocation = "";
  String SumofPricePaid = "";
  String MAN_DAYS = "";
  String perSeatProductivity = "";
  String AvgManDays = "0";
  String ProjTeamWise = "";

  ProjectionModel(
      {required this.TeamSeq,
      required this.TeamLocation,
      required this.SumofPricePaid,
      required this.MAN_DAYS,
      required this.perSeatProductivity,
      required this.AvgManDays,
      required this.ProjTeamWise});

  ProjectionModel.fromJson(Map<String, dynamic> json) {
    TeamSeq = json['TeamSeq'] ?? "";
    TeamLocation = json['TeamLocation'] ?? "";
    SumofPricePaid = json['SumofPricePaid'] ?? "";
    MAN_DAYS = json['MAN_DAYS'] ?? "";
    perSeatProductivity = json['perSeatProductivity'] ?? "";
    AvgManDays = json['AvgManDays'] ?? "";
    ProjTeamWise = json['ProjTeamWise'] ?? "0";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TeamSeq'] = this.TeamSeq;
    data['TeamLocation'] = this.TeamLocation;
    data['SumofPricePaid'] = this.SumofPricePaid;
    data['MAN_DAYS'] = this.MAN_DAYS;
    data['perSeatProductivity'] = this.perSeatProductivity;
    data['AvgManDays'] = this.AvgManDays;
    data['ProjTeamWise'] = this.ProjTeamWise;
    return data;
  }
}
