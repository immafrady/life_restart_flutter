import 'dart:math';

import '../types.dart';

// 带权重的随机
int weightRandom(List<RecordWeight> list) {
  var totalWeights = 0.0;
  for (var (key: _, :weight) in list) {
    totalWeights += weight;
  }

  var random = Random().nextDouble() * totalWeights;
  for (var (:key, :weight) in list) {
    random -= weight;
    if (random < 0) {
      return key;
    }
  }
  return list.last.key;
}
