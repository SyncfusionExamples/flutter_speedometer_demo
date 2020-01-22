import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speedometer Demo',
      theme: ThemeData( brightness: Brightness.dark,
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Speedometer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer _timer;
  double _value = 130;

  _MyHomePageState() {
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (_timer) {
      setState(() {
        _value = (Random().nextDouble() * 40) + 60;
        _value = double.parse(_value.toStringAsFixed(1));
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(

        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(startAngle: 270,
                  endAngle: 270,
                  minimum: 0,
                  maximum: 80,
                  interval: 10,
                  radiusFactor: 0.4,
                  showAxisLine: false,
                  showLastLabel: false,
                  minorTicksPerInterval: 4,
                  majorTickStyle: MajorTickStyle(
                      length: 8, thickness: 3, color: Colors.white),
                  minorTickStyle: MinorTickStyle(
                      length: 3, thickness: 1.5, color: Colors.grey),
                  axisLabelStyle: GaugeTextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                  onLabelCreated: labelCreated
              ),
              RadialAxis(minimum: 0,
                  maximum: 200,
                  labelOffset: 30,
                  axisLineStyle: AxisLineStyle(
                      thicknessUnit: GaugeSizeUnit.factor, thickness: 0.03),
                  majorTickStyle: MajorTickStyle(
                      length: 6, thickness: 4, color: Colors.white),
                  minorTickStyle: MinorTickStyle(
                      length: 3, thickness: 3, color: Colors.white),
                  axisLabelStyle: GaugeTextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                  ranges: <GaugeRange>[
                    GaugeRange(startValue: 0,
                        endValue: 200,
                        sizeUnit: GaugeSizeUnit.factor,
                        startWidth: 0.03,
                        endWidth: 0.03,
                        gradient: SweepGradient(
                            colors: const<Color>[
                              Colors.green,
                              Colors.yellow,
                              Colors.red
                            ],
                            stops: const<double>[0.0, 0.5, 1]))
                  ],
                  pointers: <GaugePointer>[
                    NeedlePointer(value: _value,
                        needleLength: 0.95,
                        enableAnimation: true,
                        animationType: AnimationType.ease,
                        needleStartWidth: 1.5,
                        needleEndWidth: 6,
                        needleColor: Colors.red,
                        knobStyle: KnobStyle(knobRadius: 0.09,sizeUnit: GaugeSizeUnit.factor))
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(widget: Container(child:
                    Column(
                        children: <Widget>[
                          Text(_value.toString(), style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                          SizedBox(height: 20),
                          Text('mph', style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold))
                        ]
                    )), angle: 90, positionFactor: 0.75)
                  ]
              )
            ]
        )
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void labelCreated(AxisLabelCreatedArgs args) {
    if (args.text == '0') {
      args.text = 'N';
      args.labelStyle = GaugeTextStyle(
          color: Colors.red, fontWeight: FontWeight.bold, fontSize: 14);
    }
    else if (args.text == '10')
      args.text = '';
    else if (args.text == '20')
      args.text = 'E';
    else if (args.text == '30')
      args.text = '';
    else if (args.text == '40')
      args.text = 'S';
    else if (args.text == '50')
      args.text = '';
    else if (args.text == '60')
      args.text = 'W';
    else if (args.text == '70')
      args.text = '';
  }
}
