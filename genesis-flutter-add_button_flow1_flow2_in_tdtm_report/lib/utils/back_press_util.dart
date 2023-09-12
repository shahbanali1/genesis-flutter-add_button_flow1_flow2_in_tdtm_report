import 'package:flutter/material.dart';
import 'dart:async';
import 'context_util.dart';
class BackPressUtil {

 static Future<bool> onBackPressed() async {
    return (await showDialog(
          context: ApplicationContext.getContext(),
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

}
