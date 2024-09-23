import 'package:flutter/material.dart';
import 'package:life_restart/core/types.dart';

class PlayerStore extends ChangeNotifier {
  Map<PropertyKey, int> pointRecord = {
    PropertyKey.charm: 0,
    PropertyKey.strength: 0,
    PropertyKey.intelligence: 0,
    PropertyKey.money: 0
  };

  int get totalPoints => pointRecord.values.reduce((total, curr) => total + curr);

  List<int> talentIds = [];

  reset() {
    pointRecord = {PropertyKey.charm: 0, PropertyKey.strength: 0, PropertyKey.intelligence: 0, PropertyKey.money: 0};
    talentIds = [];
  }
}
