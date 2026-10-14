import 'package:flutter/material.dart';

class RoutesAll extends StatefulWidget {
  const RoutesAll({super.key});

  @override
  State<RoutesAll> createState() => _RoutesAllState();
}

class _RoutesAllState extends State<RoutesAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Routes', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
