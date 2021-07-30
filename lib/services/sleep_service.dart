import 'dart:async' show Future;
import 'package:staggered_view/models/sleep_model.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

// διαβαζω απο το αρχεο json με ασυγχρονο τροπο τα δεδομενα

Future<String> _loadSleepAsset() async {
  return await rootBundle.loadString('assets/sleep.json');
}

Future loadSleep() async {
  String jsonSleep = await _loadSleepAsset();
  final jsonResponse = json.decode(jsonSleep);
  SleepList sleepList = SleepList.fromJson(jsonResponse);
  return sleepList;
}
