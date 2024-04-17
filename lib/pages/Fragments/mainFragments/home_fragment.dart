import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kushi_3/model/globals.dart' as globals;
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'dart:math' as math;
import 'package:flutter_health_connect/flutter_health_connect.dart';
import 'dart:async';
import 'dart:developer' as developer;

class HomeFragment extends StatefulWidget{
  const HomeFragment({super.key});

  @override
  State<HomeFragment> createState() => Home_Fragment();
}


class Home_Fragment extends State<HomeFragment> {

  List<HealthConnectDataType> types = [
    HealthConnectDataType.Steps,
    HealthConnectDataType.TotalCaloriesBurned
  ];
  bool readOnly = false;
  String resultText = '';

  Future<int> fetchTotalTime() async {
    var startTime = DateTime.now().subtract(Duration(
      hours: DateTime.now().hour,
      minutes: DateTime.now().minute,
      seconds: DateTime.now().second,
      milliseconds: DateTime.now().millisecond,
      microseconds: DateTime.now().microsecond,
    ));
    var endTime = DateTime.now();
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
    var timeTotal = 0;
    for(var step in stepList){
      timeTotal += (step['endTime']['epochSecond'] - step['startTime']['epochSecond']) as int;
    }
    return timeTotal;
  }

  Future<int> fetchTotalSteps() async {
    var startTime = DateTime.now().subtract(Duration(
      hours: DateTime.now().hour,
      minutes: DateTime.now().minute,
      seconds: DateTime.now().second,
      milliseconds: DateTime.now().millisecond,
      microseconds: DateTime.now().microsecond,
    ));
    var endTime = DateTime.now();
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
    var timeTotal = 0;
    //developer.log(typePoints.toString());
    var totalSteps = 0;
    for(var step in stepList){
      totalSteps+=step['count'] as int;
      //developer.log((step['endTime']['epochSecond'] - step['startTime']['epochSecond']).toString());
      timeTotal += (step['endTime']['epochSecond'] - step['startTime']['epochSecond']) as int;
    }
    developer.log(timeTotal.toString());
    return totalSteps;
  }

  Future<int> fetchTotalCalories() async {
    var startTime = DateTime.now().subtract(Duration(
      hours: DateTime.now().hour,
      minutes: DateTime.now().minute,
      seconds: DateTime.now().second,
      milliseconds: DateTime.now().millisecond,
      microseconds: DateTime.now().microsecond,
    ));
    var endTime = DateTime.now();
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
    typePoints = typePoints['TotalCaloriesBurned'];
    var totalEnergy = 0.0;
    var counter = 0;
    for (var record in typePoints.values){
      if(counter == 1){
        break;
      }
      for(var energy in record){
        totalEnergy += energy['energy']['kilocalories'].toInt();
      }
      counter++;
    }
    return totalEnergy.toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(20.0),
        color: Theme.of(context).colorScheme.background,
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Hello ',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 2.0,
                          color: Theme.of(context).colorScheme.primary,
                          offset: Offset(2.0, 2.0),
                        )
                      ],
                    ),
                  ),
                  Text(
                    globals.userName,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 40.0,
                    ),
                  ),
                  SizedBox(
                    width: 70,
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.notifications,
                      size: 35,
                    ),
                    onTap: () {

                    },
                  ),

                ],
              ),
              SizedBox(height:20,),

              // CircleStatus(),
              ConcentricCirclesWithImage(),
              SizedBox(height: 20,),

              Row(
                children: [

                  SizedBox(width: 20), // Add some space between the text and the box
                  Container(
                    margin: EdgeInsets.only(left: 70),
                    width: 60, // Adjust width as needed
                    height: 60, // Adjust height as needed
                    decoration: BoxDecoration(
                      color: Color(0x4CF75858), // Set the color to F75858 with 30% opacity
                      borderRadius: BorderRadius.circular(10), // Adjust border radius as needed
                    ),
                    child: Center(
                        child: Icon(Icons.directions_walk_rounded,size: 50,
                          color: Color(0xFFF75858),)
                    ),
                  ),
                  SizedBox(width: 10), // Add some space between the box and the text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Steps',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.bold

                          ),
                        ),
                        SizedBox(height: 0), // Add some space between the text and the box
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: FutureBuilder<int>(
                              future: fetchTotalSteps(),
                              builder: (context, snapshot) {
                                if(snapshot.connectionState == ConnectionState.waiting){
                                  return Text(
                                    'Waiting',
                                    style: TextStyle(fontSize: 30, color: Colors.grey[600]),
                                  );
                                }
                                else if(snapshot.hasError){
                                  developer.log(snapshot.error.toString());
                                  return Text(
                                    'Error',
                                    style: TextStyle(fontSize: 30, color: Colors.grey[600]),
                                  );
                                }
                                else{
                                  return Text(
                                    '${snapshot.data}',
                                    style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                                  );
                                }
                              }
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25,),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        SizedBox(width: 20), // Add some space between the text and the box
                        Container(
                          // margin: EdgeInsets.only(left: 50),
                          width: 45, // Adjust width as needed
                          height: 45, // Adjust height as needed
                          decoration: BoxDecoration(
                            color: Color(0x4C85DE2B), // Set the color to F75858 with 30% opacity
                            borderRadius: BorderRadius.circular(10), // Adjust border radius as needed
                          ),
                          child: Center(
                            child:LineIcon(LineIcons.clock,color: Colors.black,size: 30,) ,
                          ),
                        ),
                        SizedBox(width: 10), // Add some space between the box and the text
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left :8.0),
                                child: Text(
                                  'Time',
                                  style: TextStyle(fontSize: 19, color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(height: 0), // Add some space between the text and the box
                              Padding(
                                padding: const EdgeInsets.only(left: .0),
                                child: FutureBuilder<int>(
                                    future: fetchTotalTime(),
                                    builder: (context, snapshot) {
                                      if(snapshot.connectionState == ConnectionState.waiting){
                                        return Text(
                                          'Waiting',
                                          style: TextStyle(fontSize: 30, color: Colors.grey[600]),
                                        );
                                      }
                                      else if(snapshot.hasError){
                                        developer.log(snapshot.error.toString());
                                        return Text(
                                          'Error',
                                          style: TextStyle(fontSize: 30, color: Colors.grey[600]),
                                        );
                                      }
                                      else{
                                        int hours = snapshot.data! ~/ 3600;
                                        int min = snapshot.data! % 60;
                                        if(hours > 1) {
                                          return Text(
                                            '${hours}hr${min}min',
                                            style: TextStyle(fontSize: 18,
                                                color: Colors.grey[600]),
                                          );
                                        }
                                        else if(min > 1) {
                                          return Text(
                                            '${min}min',
                                            style: TextStyle(fontSize: 30,
                                                color: Colors.grey[600]),
                                          );
                                        }
                                        else{
                                          return Text(
                                            'No Excercise',
                                            style: TextStyle(fontSize: 30,
                                                color: Colors.grey[600]),
                                          );
                                        }
                                      }
                                    }
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20), // Add some space between the two rows
                  Expanded(
                    child: Row(
                      children: [
                        SizedBox(width: 20), // Add some space between the text and the box
                        Container(
                          // margin: EdgeInsets.only(left: 50),
                          width: 45, // Adjust width as needed
                          height: 45, // Adjust height as needed
                          decoration: BoxDecoration(
                            color: Color(0x4C2BAEF7), // Set the color to F75858 with 30% opacity
                            borderRadius: BorderRadius.circular(10), // Adjust border radius as needed
                          ),
                          child: Center(
                              child: Image.asset(
                                "assets/icons/calorie.png",
                                height:30 ,
                                width: 30,
                              )
                          ),
                        ),
                        SizedBox(width: 10), // Add some space between the box and the text
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Calories',
                                style: TextStyle(fontSize: 19, color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 0), // Add some space between the text and the box
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: FutureBuilder<int>(
                                    future: fetchTotalCalories(),
                                    builder: (context, snapshot) {
                                      if(snapshot.connectionState == ConnectionState.waiting){
                                        return Text(
                                          'Waiting',
                                          style: TextStyle(fontSize: 30, color: Colors.grey[600]),
                                        );
                                      }
                                      else if(snapshot.hasError){
                                        return Text(
                                          'Error',
                                          style: TextStyle(fontSize: 30, color: Colors.grey[600]),
                                        );
                                      }
                                      else{
                                        return Text(
                                          '${snapshot.data}',
                                          style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                                        );
                                      }
                                    }
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),



            ],
          ),
        ),
      ),
    ) ;
  }


}


class ConcentricCirclesWithImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ConcentricCircles(),
        Image.asset(
          "assets/icons/footsteps.png", // Replace 'your_image.png' with your image asset path

          width: 60, // Adjust image size as needed
          height: 64,
        ),
      ],
    );
  }
}
class ConcentricCircles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Transform.rotate(
        angle: math.pi,
        child: CircularPercentIndicator(
          radius: 160, // Adjust the radius as needed
          lineWidth: 20,
          percent: 0.4,
          backgroundColor: Colors.white, // Set background color to white
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: Colors.blue,
          center: CircularPercentIndicator(
            radius: 120, // Adjust the radius as needed
            lineWidth: 20,
            percent: 0.6,
            backgroundColor: Colors.white, // Set background color to white
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: Colors.green,
            center: CircularPercentIndicator(
              radius: 80, // Adjust the radius as needed
              lineWidth: 20,
              percent: 0.2,
              backgroundColor: Colors.white, // Set background color to white
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}