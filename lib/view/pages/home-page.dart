import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String title;

  HomePage({ this.title });

  @override
    Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(child: Text('hogeghoge'),),
    );
}