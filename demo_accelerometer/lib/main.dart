import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<double> _accelerometerValues;

  double xIc1 = -25.0;
  double xIc2 = 0.0;
  double xIc3 = -10.0;
  double scale = 1920 / 1080;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      _accelerometerValues = <double>[event.x, event.y, event.z];
      print('${event.x}');
      if ((_accelerometerValues[0] < 0)) {
        setState(() {
          xIc1 = xIc1 < 0 ? xIc1 + .5 : 0.0;
          xIc2 = xIc2 > -50 ? xIc2 - .8 : -50;
          xIc3 = xIc3 > -50 ? xIc3 - 1.2 : -50;
        });
      } else {
        setState(() {
          xIc1 = xIc1 > -50 ? xIc1 - .5 : -50;
          xIc2 = xIc2 < 0 ? xIc2 + .8 : 0.0;
          xIc3 = xIc3 < 0 ? xIc3 + 1.2 : 0.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: new Stack(
            children: <Widget>[
              parallax(),
              info(),
            ],
          )),
    );
  }

  Widget info() {
    return new Container(
      child: new Center(
          child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Text(
            'FLUTTER',
            style: new TextStyle(
              color: Colors.blue,
              letterSpacing: 6,
              fontSize: 50,
              fontFamily: 'arcadeclassic',
              fontWeight: FontWeight.bold,
            ),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                'DEMO',
                style: new TextStyle(
                  color: Colors.green,
                  letterSpacing: 6,
                  fontSize: 30,
                  fontFamily: 'arcadeclassic',
                  fontWeight: FontWeight.bold,
                ),
              ),
              new Text(
                ' Accelerometer',
                style: new TextStyle(
                  color: Colors.green,
                  letterSpacing: 2,
                  fontSize: 14,
                  fontFamily: 'arcadeclassic',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          new Divider(
            height: 50,
            color: Colors.transparent,
          ),
          new Text(
            'font : arcadeclassic',
            style: new TextStyle(
              color: Colors.lightBlue,
              letterSpacing: 1,
              fontSize: 14,
              fontFamily: 'arcadeclassic',
              fontWeight: FontWeight.normal,
            ),
          ),
          new Text(
            'image : opengameart.org',
            style: new TextStyle(
              color: Colors.lightBlue,
              letterSpacing: 1,
              fontSize: 14,
              fontFamily: 'arcadeclassic',
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      )),
    );
  }

  Widget parallax() {
    return new Stack(
      children: <Widget>[
        new Positioned(
            left: xIc1,
            bottom: 0,
            top: 0,
            child: new Container(
              width: MediaQuery.of(context).size.width + 250,
              height: MediaQuery.of(context).size.height,
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      fit: BoxFit.cover,
                      image: new AssetImage('assets/layer_01_1920x1080.png'))),
            )),
        new Positioned(
            left: xIc2,
            bottom: 0,
            child: new Container(
              width: MediaQuery.of(context).size.width + 250,
              height: (MediaQuery.of(context).size.width + 250) / scale,
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new AssetImage('assets/layer_02_1920x1080.png'))),
            )),
        new Positioned(
            left: xIc3,
            bottom: 0,
            child: new Container(
              width: MediaQuery.of(context).size.width + 100,
              height: (MediaQuery.of(context).size.width + 100) / scale,
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      fit: BoxFit.cover,
                      image: new AssetImage('assets/layer_03_1920x1080.png'))),
            )),
        new Positioned(
            left: xIc2,
            bottom: 0,
            child: new Container(
              width: MediaQuery.of(context).size.width + 100,
              height: (MediaQuery.of(context).size.width + 100) / scale,
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      fit: BoxFit.cover,
                      image: new AssetImage('assets/layer_04_1920x1080.png'))),
            )),
        new Positioned(
            left: xIc1,
            bottom: 0,
            child: new Container(
              width: MediaQuery.of(context).size.width + 100,
              height: (MediaQuery.of(context).size.width + 100) / scale,
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      fit: BoxFit.cover,
                      image: new AssetImage('assets/layer_05_1920x1080.png'))),
            )),
      ],
    );
  }
}
