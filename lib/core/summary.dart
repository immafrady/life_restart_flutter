import 'dart:math';

import 'package:life_restart/core/types.dart';

import 'property/record.dart';

enum Grade {
  i,
  ii,
  iii,
  iv,
}

({String judge, Grade grade}) getSummary(PropertyKey key, int score) {
  return switch (key) {
    PropertyKey.charm => switch (score) {
        > 11 => (judge: '逆天', grade: Grade.iv),
        > 9 => (judge: '罕见', grade: Grade.iii),
        > 7 => (judge: '优秀', grade: Grade.ii),
        > 4 => (judge: '普通', grade: Grade.i),
        > 2 => (judge: '不佳', grade: Grade.i),
        > 1 => (judge: '折磨', grade: Grade.i),
        _ => (judge: '地狱', grade: Grade.i),
      },
    PropertyKey.money => switch (score) {
        > 11 => (judge: '逆天', grade: Grade.iv),
        > 9 => (judge: '罕见', grade: Grade.iii),
        > 7 => (judge: '优秀', grade: Grade.ii),
        > 4 => (judge: '普通', grade: Grade.i),
        > 2 => (judge: '不佳', grade: Grade.i),
        > 1 => (judge: '折磨', grade: Grade.i),
        _ => (judge: '地狱', grade: Grade.i),
      },
    PropertyKey.spirit => switch (score) {
        > 11 => (judge: '天命', grade: Grade.iv),
        > 9 => (judge: '极乐', grade: Grade.iii),
        > 7 => (judge: '幸福', grade: Grade.ii),
        > 4 => (judge: '普通', grade: Grade.i),
        > 2 => (judge: '不佳', grade: Grade.i),
        > 1 => (judge: '折磨', grade: Grade.i),
        _ => (judge: '地狱', grade: Grade.i),
      },
    PropertyKey.intelligence => switch (score) {
        > 501 => (judge: '仙魂', grade: Grade.iv),
        > 131 => (judge: '元神', grade: Grade.iv),
        > 21 => (judge: '识海', grade: Grade.iv),
        > 11 => (judge: '逆天', grade: Grade.iv),
        > 9 => (judge: '罕见', grade: Grade.iii),
        > 7 => (judge: '优秀', grade: Grade.ii),
        > 4 => (judge: '普通', grade: Grade.i),
        > 2 => (judge: '不佳', grade: Grade.i),
        > 1 => (judge: '折磨', grade: Grade.i),
        _ => (judge: '地狱', grade: Grade.i),
      },
    PropertyKey.strength => switch (score) {
        > 2001 => (judge: '仙体', grade: Grade.iv),
        > 1001 => (judge: '元婴', grade: Grade.iv),
        > 401 => (judge: '金丹', grade: Grade.iv),
        > 101 => (judge: '筑基', grade: Grade.iv),
        > 21 => (judge: '凝气', grade: Grade.iv),
        > 11 => (judge: '逆天', grade: Grade.iv),
        > 9 => (judge: '罕见', grade: Grade.iii),
        > 7 => (judge: '优秀', grade: Grade.ii),
        > 4 => (judge: '普通', grade: Grade.i),
        > 2 => (judge: '不佳', grade: Grade.i),
        > 1 => (judge: '折磨', grade: Grade.i),
        _ => (judge: '地狱', grade: Grade.i),
      },
    PropertyKey.age => switch (score) {
        > 500 => (judge: '仙寿', grade: Grade.iv),
        > 100 => (judge: '修仙', grade: Grade.iv),
        > 95 => (judge: '不老', grade: Grade.iv),
        > 90 => (judge: '南山', grade: Grade.iii),
        > 80 => (judge: '杖朝', grade: Grade.iii),
        > 70 => (judge: '古稀', grade: Grade.ii),
        > 60 => (judge: '花甲', grade: Grade.ii),
        > 40 => (judge: '中年', grade: Grade.i),
        > 18 => (judge: '盛年', grade: Grade.i),
        > 10 => (judge: '少年', grade: Grade.i),
        > 1 => (judge: '早夭', grade: Grade.i),
        _ => (judge: '胎死腹中', grade: Grade.i),
      },
    PropertyKey.summary => switch (score) {
        > 120 => (judge: '传说', grade: Grade.iv),
        > 110 => (judge: '逆天', grade: Grade.iv),
        > 100 => (judge: '罕见', grade: Grade.iii),
        > 80 => (judge: '优秀', grade: Grade.ii),
        > 60 => (judge: '普通', grade: Grade.i),
        > 50 => (judge: '不佳', grade: Grade.i),
        > 41 => (judge: '折磨', grade: Grade.i),
        _ => (judge: '地狱', grade: Grade.i),
      },
    _ => (judge: '', grade: Grade.i),
  };
}

int calcScore(List<AgeRecord> records, PropertyKey key) {
  var score = 0;
  for (var record in records) {
    score = max(record.attributes[key] ?? 0, score);
  }
  return score;
}
