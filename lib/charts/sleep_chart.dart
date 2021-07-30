import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class StackedAreaCustomColorLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  StackedAreaCustomColorLineChart(this.seriesList, {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory StackedAreaCustomColorLineChart.withSampleData(
      List<SleepData> sleepData) {
    return new StackedAreaCustomColorLineChart(
      _createSampleData(sleepData),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(seriesList,
        defaultRenderer:
            new charts.LineRendererConfig(includeArea: true, stacked: true),
        animate: animate);
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<ChartData, int>> _createSampleData(
      List<SleepData> sleepData) {
    List<ChartData> chartData = new List<ChartData>();

    for (var i = 0; i < sleepData.length; i++) {
      chartData.add(new ChartData(i, sleepData[i].minutes));
    }

    return [
      new charts.Series<ChartData, int>(
        id: 'Desktop',
        // colorFn specifies that the line will be blue.
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        // areaColorFn specifies that the area skirt will be light blue.
        areaColorFn: (_, __) =>
            charts.MaterialPalette.blue.shadeDefault.lighter,
        domainFn: (ChartData sleep, _) => sleep.day,
        measureFn: (ChartData sleep, _) => sleep.sleep,
        data: chartData,
      ),
    ];
  }
}

/// Sample linear data type.
class ChartData {
  final int day;
  final int sleep;

  ChartData(this.day, this.sleep);
}

class SleepData {
  final int minutes;
  SleepData(this.minutes);
}
