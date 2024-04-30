import 'package:flutter/material.dart';
import 'package:kushi_3/components/bar_graph/bar_graph.dart';

class ActivityFragment extends StatefulWidget {
  const ActivityFragment({super.key});

  @override
  State<ActivityFragment> createState() => _ActivityFragmentState();
}

class _ActivityFragmentState extends State<ActivityFragment> {
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
