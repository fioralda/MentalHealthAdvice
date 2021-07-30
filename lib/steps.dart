import 'package:flutter/material.dart';
import 'package:staggered_view/services/calories_service.dart';
import 'main_drawer.dart';
import './charts/groupedbarchart.dart';
import 'package:staggered_view/models/steps_model.dart';
import 'package:staggered_view/models/calories_model.dart';
import './services/steps_service.dart';
import './services/calories_service.dart';

class Steps extends StatefulWidget {
  Steps();
  @override
  StepsState createState() => StepsState();
}

//λιστες που θα μου χρειαστουν
class StepsState extends State<Steps> {
  List<StepsDay> _steps;
  List<Calories> _calories;
  List<ChartData> _stepsValues = new List<ChartData>();
  List<ChartData> _caloriesValues = new List<ChartData>();
  bool _loadded = false;

  @override
  void initState() {
    super.initState();
    loadSteps().then((value) => setState(() {
          //για καθε ημερα φορτωνω dateTime & value(steps)
          _steps = value.days;
          _steps.forEach((e) {
            _stepsValues.add(new ChartData(e.dateTime, e.value));
          });
        }));

    loadCalories().then((value) => setState(() {
          //για καθε ημερα φορτωνω dateTime & value(calories)
          _calories = value.days;
          _calories.forEach((e) {
            _caloriesValues.add(new ChartData(e.dateTime, e.value));
          });
        }));
    _loadded = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Steps")),
      drawer: MainDrawer(), //custom drawer
      body: _loadded
          ? Center(
              child:
                  GroupedBarChart.withSampleData(_stepsValues, _caloriesValues),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
