import 'package:flutter/material.dart';
import 'package:knob_widget/knob_widget.dart';

class Controler extends StatefulWidget {
  @override
  State<Controler> createState() => _ControlerState();
}

class _ControlerState extends State<Controler> {
  final double _minimum = 0;
  final double _maximum = 4;
  final double _step = 1; // Incremental step for smoother transitions

  late KnobController _controller;
  late double _knobValue;

  void valueChangedListener(double value) {
    if (mounted) {
      setState(() {
        // Round to the nearest step value
        _knobValue = (value / _step).round() * _step;
        _knobValue = _knobValue.clamp(_minimum, _maximum); // Clamp within range
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _knobValue = _minimum;
    _controller = KnobController(
      initial: _knobValue,
      minimum: _minimum,
      maximum: _maximum,
      startAngle: 0,
      endAngle: 180,
    );
    _controller.addOnValueChangedListener(valueChangedListener);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 235,
      width: 360,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.lightBlue[100],
      ),
      child: Column(
        children: [
          SizedBox(height: 39),
          Knob(
            controller: _controller,
            width: 160,
            height: 160,
            style: KnobStyle(
              labelStyle: Theme.of(context).textTheme.bodyLarge,
              tickOffset: 0,
              labelOffset: 0,
              showLabels: true,
              showMinorTickLabels: true,
              controlStyle: ControlStyle(
                
                tickStyle: ControlTickStyle(
                  count: 40,

                ),
                

              )
            ),
          ),
          // SizedBox(height: 5),
          Text(
            "Speed : ${_knobValue.round()}",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.removeOnValueChangedListener(valueChangedListener);
    super.dispose();
  }
}
