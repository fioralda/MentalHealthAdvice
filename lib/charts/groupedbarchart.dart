import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GroupedBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  GroupedBarChart(this.seriesList, {this.animate});

  factory GroupedBarChart.withSampleData(
      List<ChartData> stepsValues, List<ChartData> caloriesValues) {
    return new GroupedBarChart(
      _createSampleData(stepsValues, caloriesValues),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.grouped,
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<dynamic, String>> _createSampleData(
      List<ChartData> stepsValues, List<ChartData> caloriesValues) {
    List<ChartData> stepsData = new List<ChartData>();
    List<ChartData> caloriesData = new List<ChartData>();

    stepsValues.forEach((e) {
      stepsData.add(new ChartData(e.dateTime.substring(5), e.value));
    });

    caloriesValues.forEach((e) {
      caloriesData.add(new ChartData(e.dateTime.substring(5), e.value));
    });

    return [
      new charts.Series<ChartData, String>(
        id: 'Steps',
        domainFn: (ChartData value, _) => value.dateTime,
        measureFn: (ChartData value, _) => value.value,
        data: stepsData,
      ),
      new charts.Series<ChartData, String>(
        id: 'Calories',
        domainFn: (ChartData value, _) => value.dateTime,
        measureFn: (ChartData value, _) => value.value,
        data: caloriesData,
      ),
    ];
  }
}

class ChartData {
  final String dateTime;
  final int value;

  ChartData(this.dateTime, this.value);
}
