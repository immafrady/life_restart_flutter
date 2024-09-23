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
        3 => 500,
        2 => 1000,
        1 => 1500,
        _ => 2000,
      };

  ColorRecord get _lightBackground => switch (widget.grade) {
        3 => (normal: const Color(0xffffa07a), active: const Color(0xffff7f4d)),
        2 => (normal: const Color(0xffe2a7ff), active: const Color(0xffb362e7)),
        1 => (normal: const Color(0xff7ea5ec), active: const Color(0xff407dec)),
        _ => (normal: const Color(0xffededed), active: const Color(0xff444444)),
      };

  ColorRecord get _darkBackground => switch (widget.grade) {
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
    final textColor = isDark ? const Color(0xffeeeeee) : const Color(0xff666666);
    final textActiveColor = isDark ? const Color(0xff3b3b3b) : const Color(0xffffffff);
    return Stack(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: widget.active ? color.active : color.normal,
            border: Border.all(color: theme.colorScheme.primary, width: 1),
            boxShadow: [
              if (widget.active)
                const BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10,
                  spreadRadius: 0,
                ),
            ],
          ),
          child: Center(
            child: Text(
              '${widget.name} (${widget.description})',
              style:
                  Theme.of(context).textTheme.titleMedium?.copyWith(color: widget.active ? textActiveColor : textColor),
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
    );
  }
}
