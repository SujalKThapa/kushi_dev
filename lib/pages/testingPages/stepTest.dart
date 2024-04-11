import 'package:kushi_3/service/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_connect/flutter_health_connect.dart';
import 'package:permission_handler/permission_handler.dart';


class stepTest extends StatefulWidget{
  const stepTest ({super.key});
  @override
  State<StatefulWidget> createState() => stepTestState();
}


class stepTestState extends State<stepTest> {

  List<HealthConnectDataType> types = [
    HealthConnectDataType.Steps,
    // HealthConnectDataType.HeartRate,
    // HealthConnectDataType.SleepSession,
    // HealthConnectDataType.OxygenSaturation,
    // HealthConnectDataType.RespiratoryRate,
  ];

  bool readOnly = true;
  String resultText = '';

  String token = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Health Connect Permission Page'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ElevatedButton(
              onPressed: () async {
                var result = await HealthConnectFactory.isApiSupported();
                resultText = 'isApiSupported: $result';
                _updateResultText();
              },
              child: const Text('isApiSupported'),
            ),
            ElevatedButton(
              onPressed: () async {
                var result = await HealthConnectFactory.isAvailable();
                resultText = 'isAvailable: $result';
                _updateResultText();
              },
              child: const Text('Check installed'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await HealthConnectFactory.installHealthConnect();
                  resultText = 'Install activity started';
                } catch (e) {
                  resultText = e.toString();
                }
                _updateResultText();
              },
              child: const Text('Install Health Connect'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await HealthConnectFactory.openHealthConnectSettings();
                  resultText = 'Settings activity started';
                } catch (e) {
                  resultText = e.toString();
                }
                _updateResultText();

              },
              child: const Text('Open Health Connect Settings'),
            ),
            ElevatedButton(
              onPressed: () async {
                var result = await HealthConnectFactory.hasPermissions(
                  types,
                  readOnly: readOnly,
                );
                resultText = 'hasPermissions: $result';
                _updateResultText();
              },
              child: const Text('Has Permissions'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  var result = await HealthConnectFactory.requestPermissions(
                    types,
                    readOnly: readOnly,
                  );
                  resultText = 'requestPermissions: $result';
                } catch (e) {
                  resultText = e.toString();
                }
                _updateResultText();
              },
              child: const Text('Request Permissions'),
            ),
            ElevatedButton(
              onPressed: () async {
                var startTime =
                DateTime.now().subtract(const Duration(days: 4));
                var endTime = DateTime.now();
                try {
                  final requests = <Future>[];
                  Map<String, dynamic> typePoints = {};
                  for (var type in types) {
                    requests.add(HealthConnectFactory.getRecord(
                      type: type,
                      startTime: startTime,
                      endTime: endTime,
                    ).then((value) => typePoints.addAll({type.name: value})));
                  }
                  await Future.wait(requests);
                  var stepList = typePoints['Steps']['records'];
                  var totalSteps = 0;
                  for(var step in stepList){
                    totalSteps+=step['count'] as int;
                  }
                  resultText = '$totalSteps';
                } catch (e) {
                  resultText = e.toString();
                  print(resultText);
                }
                _updateResultText();
              },
              child: const Text('Get Steps'),
            ),
            ElevatedButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AuthGate()),
              );
            },
            child: const Text('Move to Main')),
            SizedBox(height: 50,),
            Text(resultText),

          ],
        ),
      ),
    );
  }

  void _updateResultText() {
    setState(() {});
  }
}