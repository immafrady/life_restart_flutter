import 'dart:math' as math;

import 'package:flutter/material.dart';

typedef ColorRecord = ({Color normal, Color active});

class TalentItemWidget extends StatefulWidget {
  const TalentItemWidget({
    super.key,
    required this.name,
    required this.description,
    required this.grade,
    required this.active,
  });

  final String name;
  final String description;
  final int grade;
  final bool active;

  @override
  State<TalentItemWidget> createState() => _TalentItemWidgetState();
}

class _TalentItemWidgetState extends State<TalentItemWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: _animationDuration),
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(covariant TalentItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.active) {
      // 当激活状态下才开始动画
      _controller.repeat();
    } else {
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int get _animationDuration => switch (widget.grade) {
        3 => 1000,
        2 => 1300,
        1 => 1600,
        _ => 1900,
      };

  ({Color bg, Color onBg}) get _colors {
    final colorScheme = Theme.of(context).colorScheme;

    return widget.active
        ? switch (widget.grade) {
            3 => (bg: colorScheme.tertiaryContainer, onBg: colorScheme.onTertiaryContainer),
            2 => (bg: colorScheme.primaryContainer, onBg: colorScheme.onPrimaryContainer),
            1 => (bg: colorScheme.secondaryContainer, onBg: colorScheme.onSecondaryContainer),
            _ => (bg: colorScheme.surfaceContainer, onBg: colorScheme.onSecondaryContainer)
          }
        : switch (widget.grade) {
            3 => (bg: colorScheme.tertiary, onBg: colorScheme.onTertiary),
            2 => (bg: colorScheme.primary, onBg: colorScheme.onPrimary),
            1 => (bg: colorScheme.secondary, onBg: colorScheme.onSecondary),
            _ => (bg: colorScheme.surface, onBg: colorScheme.onSurface)
          };
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final (bg: bgColor, onBg: onBgColor) = _colors;

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      color: bgColor,
      child: Stack(
        children: [
          ListTile(
            dense: true,
            visualDensity: VisualDensity.compact,
            title: Text(
              widget.name,
              style: textTheme.titleSmall?.copyWith(
                color: onBgColor,
              ),
            ),
            subtitle: Text(
              widget.description,
              style: textTheme.bodySmall?.copyWith(
                color: onBgColor,
              ),
            ),
          ),
          if (widget.active)
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) => Opacity(
                  opacity: _controller.value,
                  child: Transform.translate(
                    // 屏幕的宽度
                    offset: Offset(_controller.value * MediaQuery.of(context).size.width * 0.8, 0),
                    child: Container(
                      color: Colors.black.withOpacity(math.sin(math.pi * _controller.value) * 0.2),
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
