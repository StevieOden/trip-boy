import 'package:flutter/material.dart';

class UploadDetail extends StatefulWidget {
  int index;
  UploadDetail({super.key, required this.index});

  @override
  State<UploadDetail> createState() => _UploadDetailState();
}

class _UploadDetailState extends State<UploadDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
    );
  }
}
