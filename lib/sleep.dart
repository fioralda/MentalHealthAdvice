import 'package:flutter/material.dart';
import 'package:staggered_view/services/sleep_service.dart';
import 'main_drawer.dart';
import 'charts/sleep_chart.dart';
import './models/sleep_model.dart';

class Sleep extends StatefulWidget {
  Sleep();
  @override
  SleepState createState() => SleepState();
}

//λιστες που θα μου χρειαστουν
class SleepState extends State<Sleep> {
  List<SleepDay> _sleep;
  List<SleepData> _sleepValues = new List<SleepData>();
  bool _loadded = false;

  @override
  void initState() {
    super.initState();
    loadSleep().then((value) => setState(() {
          //φορτωνω για καθε ημερα τα SleepData
          _sleep = value.days;
          _sleep.forEach((e) {
            _sleepValues.add(new SleepData(e.minutesAsleep));
          });
          _loadded = true;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sleep")),
      drawer: MainDrawer(), //custom drawer
      body: _loadded
          ? Center(
              child:
                  StackedAreaCustomColorLineChart.withSampleData(_sleepValues),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
