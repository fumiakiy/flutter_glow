import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'glow_view.dart';

class GlowViewState extends State<GlowView> {
  static const MethodChannel methodChannel = MethodChannel('flutter.luckypines.com/screen_dimmer');

  double _dimLevel;
  Color _color;

  GlowViewState(this._dimLevel, this._color);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        methodChannel.invokeMethod("setDimLevel", 0).then((dimValue) {
          setState(() {
            _color = Colors.red;
            _dimLevel = dimValue;
          });
        });
      },
      child: Container(
        color: _color,
      ),
    );
  }
}