import 'package:flutter/material.dart';
import 'main_drawer.dart';
import './models/me_model.dart';
import './services/me_service.dart';

class Demographics extends StatefulWidget {
  Demographics();
  @override
  DemographicsState createState() => DemographicsState();
}

class DemographicsState extends State<Demographics> {
  bool _loaded = false;
  Me _profile;
// φορτωνω τα δεδομενα απο το αρχειο json
  @override
  void initState() {
    super.initState();
    loadMe().then((value) => setState(() {
          print(value);
          _loaded = true;
          _profile = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Demographics")),
        drawer: MainDrawer(), //custom drawer
        body: _loaded
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(46),
                    child: Image.network(
                      _profile.avatar640,
                      height: 92,
                      width: 92,
                    ),
                  ),
                  Text(
                    _profile.displayName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _profile.dateOfBirth,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ))
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
