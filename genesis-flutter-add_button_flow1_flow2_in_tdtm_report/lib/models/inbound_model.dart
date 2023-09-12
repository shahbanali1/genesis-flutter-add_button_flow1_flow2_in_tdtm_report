import 'package:management_app/models/base_model.dart';

class InboundModel extends BaseModel {
  String? timeSlot;
  String? avgMonth;
  String? avgWeekDay;
  String? callToday;

  InboundModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    timeSlot = json['TimeSlot'];
    avgMonth = json['AvgMonth'];
    avgWeekDay = json['AvgWeekDay'];
    callToday = json['CallToday'];
  }
}
