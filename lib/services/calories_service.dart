import 'dart:async' show Future;
import 'package:staggered_view/models/calories_model.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

// διαβαζω απο το αρχεο json με ασυγχρονο τροπο τα δεδομενα
Future<String> _loadCaloriesAsset() async {
  return await rootBundle.loadString('assets/calories.json');
}

Future loadCalories() async {
  String jsonCalories = await _loadCaloriesAsset();
  final jsonResponse = json.decode(jsonCalories);
  CaloriesList caloriesList = CaloriesList.fromJson(jsonResponse);
  return caloriesList;
}
