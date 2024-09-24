import 'package:flutter/material.dart';
import 'package:life_restart/core/types.dart';

class PlayerStore extends ChangeNotifier {
  late Map<PropertyKey, int> pointRecord = getBasePointRecord();

  int get totalPoints => pointRecord.values.reduce((total, curr) => total + curr);

  List<int> talentIds = [];

  reset() {
    pointRecord = getBasePointRecord();
    talentIds = [];
  }

  getBasePointRecord() =>
      {PropertyKey.charm: 0, PropertyKey.strength: 0, PropertyKey.intelligence: 0, PropertyKey.money: 0};
}
