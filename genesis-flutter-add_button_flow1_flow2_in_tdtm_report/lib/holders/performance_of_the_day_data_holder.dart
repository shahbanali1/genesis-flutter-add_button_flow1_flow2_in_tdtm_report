import 'package:management_app/ui/widgets/performance_of_the_day_header.dart';

class PerformanceOfTheDayDataHolder {
  static final PerformanceOfTheDayDataHolder _screenHandler =
      PerformanceOfTheDayDataHolder._internal();

  factory PerformanceOfTheDayDataHolder() {
    return _screenHandler;
  }

  PerformanceOfTheDayDataHolder._internal();

  String process = 'HM';
  String location = 'Gurgoan';
  String count = "10";

  PerformanceOfTheDayHeader? _header;

  PerformanceOfTheDayHeader getPerformanceOfTheDayHeader() {
    _header ??= const PerformanceOfTheDayHeader();
    return _header!;
  }
}
