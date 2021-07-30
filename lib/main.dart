import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:staggered_view/models/heart_model.dart';
import 'package:staggered_view/models/sleep_model.dart';
import 'package:staggered_view/models/steps_model.dart';
import 'package:staggered_view/services/heart_service.dart';
import 'package:staggered_view/services/steps_service.dart';
import './main_drawer.dart';
import 'steps.dart';
import 'heartRate.dart';
import 'sleep.dart';
import 'demographics.dart';
import './services/heart_service.dart';
import './services/steps_service.dart';

void main() {
  runApp(MaterialApp(title: "Dashboard", routes: {
    '/': (context) => MyApp(),
    '/heartrate': (context) => Heartrate(),
    '/steps': (context) => Steps(),
    '/sleep': (context) => Sleep(),
    '/demographics': (context) => Demographics(),
  }));
}

class MyApp extends StatefulWidget {
  MyApp();
  @override
  MyAppState createState() => MyAppState();
}

//οι λιστες που θα μου χρειαστουν
class MyAppState extends State<MyApp> {
  List<SleepDay> _sleepdays;
  List<HeartRate> _heartdays;
  List<StepsDay> _steps;
  bool _loadded = false;
  List<double> heartData = [90, 86, 82, 86, 80, 79, 82];

  List<CircularStackEntry> circularData = <CircularStackEntry>[
    new CircularStackEntry(
      <CircularSegmentEntry>[
        new CircularSegmentEntry(2000, Colors.orange,
            rankKey:
                'Steps'), // δεδομενα σε περιπτωση που δε φορτωσουν τα json αρχεία
        new CircularSegmentEntry(6000, Colors.grey, rankKey: 'Goas'),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    loadHeart().then((value) => setState(() {
          _heartdays = value.days;
          List<double> newData = new List<double>();
          _heartdays.forEach((e) => newData.add(e.avarage.ceilToDouble()));
          heartData = newData;
          _loadded = true;
        }));
    loadSteps().then((value) => setState(() {
          _loadded = false;
          _steps = value.days;

          circularData = <CircularStackEntry>[
            new CircularStackEntry(
              <CircularSegmentEntry>[
                new CircularSegmentEntry(
                    //παιρνω τα steps της τελευταιας μερας
                    _steps[_steps.length - 1].value.ceilToDouble(),
                    Colors.orange,
                    rankKey: 'Steps'),
                new CircularSegmentEntry(
                    // η διαφορα απο τα steps της τελευταιας μερας μεχρι να φτασω στο Goas
                    8000 - _steps[_steps.length - 1].value.ceilToDouble(),
                    Colors.grey,
                    rankKey: 'Goas'),
              ],
            ),
          ];

          _loadded = true;
        }));
  }

  Widget myItems(
      IconData icon, String heading, Color color, Function pageHandler) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      shadowColor: Colors.grey,
      borderRadius: BorderRadius.circular(24.0),
      child: InkWell(
        child: Container(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          heading,
                          style: TextStyle(color: Colors.blue, fontSize: 19.0),
                        ),
                      ),
                      Material(
                        color: color,
                        borderRadius: BorderRadius.circular(24.0),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(icon, color: Colors.white, size: 30.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        onTap: pageHandler,
      ),
    );
  }

  Widget mychart1Items(String title, Function pageHandler) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Colors.grey,
      child: InkWell(
        child: Container(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(1.0),
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(1.0),
                          child: new Sparkline(
                            //το γραφημε σε μορφη γραμμης
                            data:
                                heartData, // τα double δεδομενα που εχουμε δηλωσει στην αρχη
                            lineColor: Colors.red,
                            pointsMode: PointsMode
                                .all, //δειχνει τα σημεια με τις τιμες σαν βουλες/points
                            pointSize: 8.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        onTap: pageHandler,
      ),
    );
  }

  Widget myCircularItems(String title, Function pageHandler) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Colors.grey,
      child: InkWell(
          child: Container(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: AnimatedCircularChart(
                            //το widget που μας δινει το package flutter_circular_chart.dart
                            size: Size(100.0, 100.0),
                            initialChartData: circularData,
                            chartType: CircularChartType
                                .Pie, //εδω δηλωνουμε τον τυπο του γραφηματος
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          onTap: pageHandler),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Dashboard",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        drawer: MainDrawer(),
        body: _loadded
            ? StaggeredGridView.count(
                crossAxisCount:
                    2, //ο αριθμος των στηλων που θελουμε να καλυπτει το grid
                crossAxisSpacing:
                    12.0, //η αποσταση μεταξυ των κουτιων στον οριζοντιο αξονα
                mainAxisSpacing:
                    12.0, //η αποσταση μεταξυ των κουτιων στον καθετο αξονα
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                children: [
                  mychart1Items("Heart Rate", () {
                    Navigator.pushNamed(context,
                        '/heartrate'); //η συναρτηση που περναμε στον pageHandler
                  }),
                  myCircularItems("Steps", () {
                    Navigator.pushNamed(context,
                        '/steps'); //η συναρτηση που περναμε στον pageHandler
                  }),
                  myItems(Icons.account_circle, "Me", Colors.blueGrey[500], () {
                    Navigator.pushNamed(context,
                        '/demographics'); //η συναρτηση που περναμε στον pageHandler
                  }),
                  myItems(IconData(0xf059, fontFamily: 'MaterialIcons'),
                      "Sleep", Colors.blueGrey[500], () {
                    Navigator.pushNamed(context,
                        '/sleep'); //η συναρτηση που περναμε στον pageHandler
                  }),
                ],
                staggeredTiles: [
                  //οσα αντικειμενα βαλαμε στο children τοσα πρεπει να βαλουμε και εδω
                  StaggeredTile.extent(2,
                      210.0), //η πρωτη παραμετρος λεει ποσες στηλες να καλυπτει το tile/κουτι
                  StaggeredTile.extent(1,
                      310.0), //δευτερη παραμετρος λεει το υψος τους tile/κουτιου
                  StaggeredTile.extent(1, 150.0),
                  StaggeredTile.extent(1, 150.0),
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
