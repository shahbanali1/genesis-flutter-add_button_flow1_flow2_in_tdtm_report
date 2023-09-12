import 'package:flutter/material.dart';

class RetailTDTMDetail {
  String teamName = "";
  int percentHeight = 0;
  Color colorCode = Colors.black;

  String getTeamName() {
    return teamName;
  }

  void setTeamName(String teamName) {
    this.teamName = teamName;
  }

  int getPercentHeight() {
    return percentHeight;
  }

  void setPercentHeight(int percentHeight) {
    this.percentHeight = percentHeight;
  }

  Color getColorCode() {
    return colorCode;
  }

  void setColorCode(Color colorCode) {
    this.colorCode = colorCode;
  }
}
