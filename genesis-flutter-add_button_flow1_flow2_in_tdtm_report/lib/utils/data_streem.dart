import 'dart:async';

class DataStreem {
  static final DataStreem _dataStreem = DataStreem._internal();

  factory DataStreem() {
    return _dataStreem;
  }

  DataStreem._internal();

  StreamController<dynamic> controller = StreamController<dynamic>.broadcast();
}
