import 'dart:async' show Future;
import 'package:staggered_view/models/heart_model.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

// διαβαζω απο το αρχεο json με ασυγχρονο τροπο τα δεδομενα

Future<String> _loadHeartAsset() async {
  return await rootBundle.loadString('assets/heart.json');
}

Future loadHeart() async {
  String jsonHeart = await _loadHeartAsset();
  final jsonResponse = json.decode(jsonHeart);
  HeartList heartList = HeartList.fromJson(jsonResponse);
  return heartList;
}
