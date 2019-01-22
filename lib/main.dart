import 'package:flutter/material.dart';
import 'glow_view.dart';

void main() => runApp(FlutterGlow());

class FlutterGlow extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GlowView(),
      ),
    );
  }
}
