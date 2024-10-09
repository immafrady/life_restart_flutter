import 'package:flutter/material.dart';

// 给children中间加间隔
List<Widget> generateSpacedChildren({
  required List<Widget> children,
  required Widget spacer,
}) {
  return List.generate(children.length * 2 - 1, (i) {
    if (i.isEven) {
      return children[i ~/ 2];
    } else {
      return spacer;
    }
  });
}
