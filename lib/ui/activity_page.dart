import 'package:flutter/material.dart';

class ActivityPage extends StatefulWidget {
  ActivityPage({Key? key}) : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Activity Page")),
    );
  }
}
