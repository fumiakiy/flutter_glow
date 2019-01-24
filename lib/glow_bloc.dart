import 'package:tuple/tuple.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GlowBloc {
  static const MethodChannel methodChannel = MethodChannel('flutter.luckypines.com/screen_dimmer');

  double _dimLevel;
  Color _color;

  PublishSubject<Tuple2<double, Color>> output = PublishSubject();

  updateColor(Color color) {
    _color = color;
    output.sink.add(Tuple2(_dimLevel, _color));
  }

  updateDimLevel(double level) {
    methodChannel.invokeMethod("setDimLevel", level).then((dimValue) {
      _dimLevel = dimValue;
      output.sink.add(Tuple2(_dimLevel, _color));
    });
  }

  dispose() {
    output.close();
  }
}