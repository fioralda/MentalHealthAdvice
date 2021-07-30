import 'package:flutter/material.dart';
import 'package:staggered_view/models/heart_model.dart';
import 'package:staggered_view/services/heart_service.dart';
import 'main_drawer.dart';
import 'charts/chart_for_heart.dart';

class Heartrate extends StatefulWidget {
  Heartrate();
  @override
  HeartState createState() => HeartState();
}

//λιστα με τα πεδια που χρειαζομαι για το Heartrate
class HeartState extends State<Heartrate> {
  List<HeartRate> _heartRate;
  List<HeartRateData> _heartValues = new List<HeartRateData>();
  bool _loadded = false;

//για την καθε μερα φορτωνω τα στοιχεια dateTime & avarage
  @override
  void initState() {
    super.initState();
    loadHeart().then((value) => setState(() {
          _heartRate = value.days;
          _heartRate.forEach((e) {
            _heartValues.add(new HeartRateData(e.dateTime, e.avarage));
          });
          _loadded = true;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Heartrate")),
      drawer: MainDrawer(),
      body: _loadded
          ? Center(
              child: HeartRateChart.withSampleData(_heartValues),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
