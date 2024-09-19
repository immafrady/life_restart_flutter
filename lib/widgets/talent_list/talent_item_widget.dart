import 'package:flutter/material.dart';

typedef ColorRecord = ({Color normal, Color active});

class TalentItemWidget extends StatelessWidget {
  const TalentItemWidget(
      {super.key,
      required this.name,
      required this.description,
      required this.grade});

  final String name;
  final String description;
  final int grade;

  ColorRecord get _lightBackground => switch (grade) {
        3 => (normal: const Color(0xffffa07a), active: const Color(0xffff7f4d)),
        2 => (normal: const Color(0xffe2a7ff), active: const Color(0xffb362e7)),
        1 => (normal: const Color(0xff7ea5ec), active: const Color(0xff407dec)),
        _ => (normal: const Color(0xffededed), active: const Color(0xff444444)),
      };

  ColorRecord get _darkBackground => switch (grade) {
        3 => (normal: const Color(0xffffa07a), active: const Color(0xfff1bfac)),
        2 => (normal: const Color(0xffe2a7ff), active: const Color(0xffe7beff)),
        1 => (normal: const Color(0xff6495ed), active: const Color(0xff87cefa)),
        _ => (normal: const Color(0xff464646), active: const Color(0xffc0c0c0)),
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final color = isDark ? _darkBackground : _lightBackground;
    final textColor =
        isDark ? const Color(0xffeeeeee) : const Color(0xff666666);
    final textActiveColor =
        isDark ? const Color(0xff3b3b3b) : const Color(0xffffffff);
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: color.normal,
          border: Border.all(color: theme.colorScheme.primary, width: 1)),
      child: Center(
          child: Text(
        '$name ($description)',
        style: TextStyle(color: textColor),
      )),
    );
  }
}
