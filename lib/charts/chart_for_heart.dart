import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HeartRateChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  HeartRateChart(this.seriesList, {this.animate});

  factory HeartRateChart.withSampleData(List<HeartRateData> heartValues) {
    return new HeartRateChart(
      _createSampleData(heartValues),
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
      List<HeartRateData> heartValues) {
    List<HeartRateData> heartData = new List<HeartRateData>();

    // Για καθεεγραφη στα Series την προσθετω στον πινακα heartData
    heartValues.forEach((e) {
      heartData.add(new HeartRateData(e.dateTime.substring(5), e.average));
    });

    return [
      new charts.Series<HeartRateData, String>(
        id: 'Steps',
        domainFn: (HeartRateData value, _) => value.dateTime,
        measureFn: (HeartRateData value, _) => value.average,
        data: heartData,
      ),
    ];
  }
}

class HeartRateData {
  final String dateTime;
  final int average;

  HeartRateData(this.dateTime, this.average);
}
