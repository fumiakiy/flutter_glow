import 'package:tuple/tuple.dart';
import 'package:flutter/material.dart';
import 'glow_view.dart';
import 'glow_bloc.dart';

class GlowViewState extends State<GlowView> {

  final _bloc = GlowBloc();

  GlowViewState() {
    _bloc.updateColor(Colors.yellow);
    _bloc.updateDimLevel(1.0);
  }

  _onRadioChanged(value) {
    _bloc.updateColor(value);
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<Tuple2<double, Color>>(
      stream: _bloc.output.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildWidget(snapshot.data.item1, snapshot.data.item2);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _buildWidget(double level, Color color) {
    return Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Slider(value: level, onChanged: (value) {
            _bloc.updateDimLevel(value);
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Radio(
                value: Colors.yellow,
                groupValue: color,
                onChanged: _onRadioChanged,
              ),
              Text(
                "Yellow",
                style: TextStyle(fontSize: 16.0),
              ),
              Radio(
                value: Colors.lightGreen,
                groupValue: color,
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
                groupValue: color,
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

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}