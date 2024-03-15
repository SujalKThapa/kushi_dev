import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';


class SelectHeight extends StatefulWidget{
  const SelectHeight({super.key});

  @override
  State<StatefulWidget> createState() => selectHeightState();
}

class selectHeightState extends State<SelectHeight> {
  var btnStyle1 =  const TextStyle(
      color: Colors.black
  );
  var btnStyle2 = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
  );
  var labels = ['Feet', 'Centimetre'];
  var heightUnit = "cm";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 60,),
            const Text("Step 4 of 8"),
            const SizedBox(height: 90,),
            const Text("Enter height", style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 29,
            ),),
            const SizedBox(height: 30,),
            ToggleSwitch(
              minWidth: 150.0,
              initialLabelIndex: 1,
              cornerRadius: 30.0,
              radiusStyle: true,
              activeBgColor: [Colors.white],
              customTextStyles:  [
                btnStyle1,
                btnStyle2
              ],
              borderColor: const [Colors.grey],
              inactiveBgColor: Colors.white54,
              inactiveFgColor: Colors.grey,
              totalSwitches: 2,
              labels: labels,
              onToggle: (index) {
                if (index != null) {
                  setState(() {
                    heightUnit = labels[index];
                    print(heightUnit);
                  });
                }
              }
            ),
          ],
        ),
      )
    );
  }
}