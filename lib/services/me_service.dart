import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:staggered_view/models/me_model.dart';

// διαβαζω απο το αρχεο json με ασυγχρονο τροπο τα δεδομενα

Future<String> _loadMeAsset() async {
  return await rootBundle.loadString('assets/profile.json');
}

Future loadMe() async {
  String jsonSteps = await _loadMeAsset();
  final jsonResponse = json.decode(jsonSteps);
  Me me = Me.fromJson(jsonResponse);
  return me;
}
