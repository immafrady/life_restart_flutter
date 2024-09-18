import 'dart:math';

import 'package:life_restart/core/property/person.dart';
import 'package:life_restart/core/utils.dart';

import '../dict/data_dict.dart';
import '../dict/talent.dart';

class TalentManager {
  DataDict<Talent> talents;

  TalentManager({required this.talents});

  // 全部talents列表（根据等级排序后）
  List<Talent> get sortedTalents =>
      talents.getAll()..sort((a, b) => b.grade - a.grade);

  List<Talent> pick10RandomTalents(int? selectedId) {
    // 根据grade划分的map
    final Map<int, List<Talent>> map = {};
    for (var talent in sortedTalents) {
      if (map[talent.grade] != null) {
        map[talent.grade]!.add(talent);
      } else {
        map[talent.grade] = [talent];
      }
    }

    final List<Talent> list = [];
    if (selectedId != null) {
      list.add(talents.get(selectedId));
    }

    // 挑十个出来
    while (list.length < 10) {
      final rnd = Random().nextDouble();
      var grade =
          switch (rnd) { >= 0.111 => 0, >= 0.011 => 1, >= 0.001 => 2, _ => 3 };
      while (map[grade]!.isEmpty) {
        // 排除掉空了的等级列表
        grade--;
      }
      final currentGradeList = map[grade]!;
      final index = Random().nextInt(currentGradeList.length); // 幸运下标
      list.add(currentGradeList.removeAt(index));
    }
    return list;
  }

  // 找出互斥的id
  int? exclusive(List<int> talentIds, int exclusiveId) {
    final targetTalent = talents.get(exclusiveId);
    if (targetTalent.exclusive.isEmpty) {
      return null;
    }

    for (var talentId in talentIds) {
      for (var targetId in targetTalent.exclusive) {
        if (targetId == talentId) {
          return talentId;
        }
      }
    }
    return null;
  }

  Talent? doTalent(int talentId, Person person) {
    final talent = talents.get(talentId);
    if (talent.condition.isNotEmpty &&
        !checkCondition(person, talent.condition)) {
      return null;
    }
    return talent;
  }
}
