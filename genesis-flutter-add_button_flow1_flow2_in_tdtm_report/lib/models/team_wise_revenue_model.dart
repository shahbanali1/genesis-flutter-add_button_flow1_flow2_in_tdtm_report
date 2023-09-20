class TeamWiseRevenueModel {
  String TeamSeq = "";
  String TeamLocation = "";
  String TeamName = "";
  String TL = "";
  String SumofPricePaid = "";
  String NoofOrders = "";
  String AvgOrderSize = "";
  String MAN_DAYS = "";
  String perSeatProductivity = "";
  String teamWisePricePaid = "";

  TeamWiseRevenueModel(
      {required this.TeamSeq,
      required this.TeamLocation,
      required this.TeamName,
      required this.TL,
      required this.SumofPricePaid,
      required this.NoofOrders,
      required this.AvgOrderSize,
      required this.MAN_DAYS,
      required this.perSeatProductivity,
      required this.teamWisePricePaid});

  TeamWiseRevenueModel.fromJson(Map<String, dynamic> json) {
    TeamSeq = json['TeamSeq'] ?? "";
    TeamLocation = json['TeamLocation'] ?? "";
    TeamName = json['TeamName'] ?? "";
    TL = json['TL'] ?? "";
    SumofPricePaid = json['SumofPricePaid'] ?? "";
    NoofOrders = json['NoofOrders'] ?? "";
    AvgOrderSize = json['AvgOrderSize'] ?? "";
    MAN_DAYS = json['MAN_DAYS'] ?? "";
    perSeatProductivity = json['perSeatProductivity'] ?? "";
    teamWisePricePaid = json['teamWisePricePaid'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TeamSeq'] = this.TeamSeq;
    data['TeamLocation'] = this.TeamLocation;
    data['TeamName'] = this.TeamName;
    data['TL'] = this.TL;
    data['SumofPricePaid'] = this.SumofPricePaid;
    data['NoofOrders'] = this.NoofOrders;
    data['AvgOrderSize'] = this.AvgOrderSize;
    data['MAN_DAYS'] = this.MAN_DAYS;
    data['perSeatProductivity'] = this.perSeatProductivity;
    data['teamWisePricePaid'] = this.teamWisePricePaid;
    return data;
  }
}
