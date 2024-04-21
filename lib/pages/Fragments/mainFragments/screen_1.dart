import 'package:flutter/material.dart';
import 'package:kushi_3/components/bar_graph/bar_graph.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  List<double> weeklySummary = [4.40, 2.50, 42.42, 30, 50, 96, 59];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
            height:200,
            child: MyBarGraph(weeklySummary: weeklySummary,)
        ),
      ),
    );
  }
}
