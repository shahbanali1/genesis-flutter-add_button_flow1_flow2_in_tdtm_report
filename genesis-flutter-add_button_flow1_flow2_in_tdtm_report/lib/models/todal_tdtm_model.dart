import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TotalTDTM {
  String center = "";
  int currentMonthRevenue = 0;
  int previousMonthRevenue = 0;
  int lastMonthRevenue = 0;
  int secondLastMonthRevenue = 0;
  Color color = Colors.black;

  String getCenter() {
    return center;
  }

  void setCenter(String center) {
    this.center = center;
  }

  int getCurrentMonthRevenue() {
    return currentMonthRevenue;
  }

  void setCurrentMonthRevenue(int currentMonthRevenue) {
    this.currentMonthRevenue = currentMonthRevenue;
  }

  int getPreviousMonthRevenue() {
    return previousMonthRevenue;
  }

  void setPreviousMonthRevenue(int previousMonthRevenue) {
    this.previousMonthRevenue = previousMonthRevenue;
  }

  int getLastMonthRevenue() {
    return lastMonthRevenue;
  }

  void setLastMonthRevenue(int lastMonthRevenue) {
    this.lastMonthRevenue = lastMonthRevenue;
  }

  int getSecondLastMonthRevenue() {
    return secondLastMonthRevenue;
  }

  void setSecondLastMonthRevenue(int secondLastMonthRevenue) {
    this.secondLastMonthRevenue = secondLastMonthRevenue;
  }

  Color getColor() {
    return color;
  }

  void setColor(Color color) {
    this.color = color;
  }
}
