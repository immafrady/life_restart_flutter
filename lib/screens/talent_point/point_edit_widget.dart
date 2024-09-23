import 'package:flutter/material.dart';
import 'package:life_restart/core/types.dart';

class PointEditWidget extends StatelessWidget {
  const PointEditWidget(
      {super.key, required this.propertyKey, required int value, required this.total, required this.onChanged})
      : value = value > total ? total : value;

  final PropertyKey propertyKey;
  final int value;
  final int total;
  final void Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(propertyKey.desc),
        Slider(
          value: value.toDouble(),
          max: total.toDouble(),
          onChanged: (v) {
            onChanged(v.toInt());
          },
        ),
        Text('$value'),
      ],
    );
  }
}
