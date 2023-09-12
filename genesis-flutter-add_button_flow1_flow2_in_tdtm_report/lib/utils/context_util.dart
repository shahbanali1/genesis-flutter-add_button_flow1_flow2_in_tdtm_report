import 'package:flutter/material.dart';

class ApplicationContext {
  static late BuildContext context;

  static setContext(BuildContext context) {
    context = context;
  }

  static getContext() {
    return context;
  }
}
