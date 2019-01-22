import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'glow_view.dart';

class GlowViewState extends State<GlowView> {
  static const MethodChannel methodChannel = MethodChannel('flutter.luckypines.com/screen_dimmer');

  double _dimLevel;
  Color _color;

  GlowViewState(this._dimLevel, this._color);

  _onRadioChanged(value) {
    setState(() {
      _color = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Slider(value: _dimLevel, onChanged: (value) {
            methodChannel.invokeMethod("setDimLevel", value).then((dimValue) {
              setState(() {
                _dimLevel = dimValue;
              });
            });
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Radio(
                value: Colors.yellow,
                groupValue: _color,
                onChanged: _onRadioChanged,
              ),
              Text(
                "Yellow",
                style: TextStyle(fontSize: 16.0),
              ),
              Radio(
                value: Colors.lightGreen,
                groupValue: _color,
                onChanged: _onRadioChanged,
              ),
              Text(
                "Green",
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              Radio(
                value: Colors.purple,
                groupValue: _color,
                onChanged: _onRadioChanged,
              ),
              Text(
                "Purple",
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ],
      )
    );
  }
}