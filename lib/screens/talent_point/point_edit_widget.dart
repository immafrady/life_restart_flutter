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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          propertyKey.desc,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        IconButton(
          onPressed: value > 0 ? () => onChanged(value - 1) : null,
          icon: const Icon(Icons.remove),
        ),
        Text(
          '$value',
          style: Theme.of(context).textTheme.bodyLarge,
          strutStyle: const StrutStyle(),
        ),
        IconButton(
          onPressed: value < total ? () => onChanged(value + 1) : null,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
