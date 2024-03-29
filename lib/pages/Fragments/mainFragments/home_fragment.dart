import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kushi_3/model/globals.dart' as globals;
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'dart:math' as math;


class Home_Fragment extends StatelessWidget {
  const Home_Fragment({super.key});
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
                        Text(
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
                          child: Text(
                            '2,760',
                            style: TextStyle(fontSize: 30, color: Colors.grey[600]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
                                child: Text(
                                  '2 hours',
                                  style: TextStyle(fontSize: 20, color: Colors.grey[600]),
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
                                padding: const EdgeInsets.only(left: 14.0),
                                child: Text(
                                  '6215',
                                  style: TextStyle(fontSize: 20, color: Colors.grey[600]),
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