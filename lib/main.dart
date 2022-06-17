import 'package:flutter/material.dart';
import 'package:picoyplaca/pages/bottom_bar.dart';

import 'pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      title: 'Pico y Placa - App',
      home: BottomBarPage(),
    );
  }
}
