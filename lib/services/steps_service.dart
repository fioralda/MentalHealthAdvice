import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:staggered_view/models/steps_model.dart';

// διαβαζω απο το αρχεο json με ασυγχρονο τροπο τα δεδομενα

Future<String> _loadStepsAsset() async {
  return await rootBundle.loadString('assets/steps.json');
}

Future loadSteps() async {
  String jsonSteps = await _loadStepsAsset();
  final jsonResponse = json.decode(jsonSteps);
  StepsList stepsList = StepsList.fromJson(jsonResponse);
  return stepsList;
}
