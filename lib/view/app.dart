import 'package:flutter/material.dart';
import 'package:mistilteinn/view/pages/home-page.dart';

const title = 'Mistilteinnn';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(primaryColor: Colors.green),
      home: HomePage(
        title: title,
      ),
    );
  }
}
