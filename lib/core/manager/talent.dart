import 'dart:math';

import '../dict/data_dict.dart';
import '../dict/talent.dart';
import '../functions/condition.dart';
import '../functions/util.dart';
import '../property/person.dart';
import '../types.dart';

class TalentManager {
  DataDict<Talent> talents;

  TalentManager({required this.talents});

  // 全部talents列表（根据等级排序后）
  List<Talent> get sortedTalents => talents.getAll()..sort((a, b) => b.grade - a.grade);

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
      var grade = switch (rnd) { >= 0.111 => 0, >= 0.011 => 1, >= 0.001 => 2, _ => 3 };
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

  // 统计可以使用的额外点数
  int getAdditionPoints(List<int> talentIds) {
    int point = 0;
    for (var talentId in talentIds) {
      point += talents.get(talentId).status;
    }
    return point;
  }

  Talent? apply(int talentId, Person person) {
    final talent = talents.get(talentId);
    if (talent.condition.isNotEmpty && !checkCondition(person, talent.condition)) {
      return null;
    }
    return talent;
  }

  // Map<原id, 替换后id> 计算id和替换后的id
  Map<int, int> replace(List<int> talentIds) {
    // 返回值是：（id, 权重)
    List<RecordWeight>? getReplaceList(int tId, List<int> tIds) {
      final talent = talents.get(tId);
      if (talent.replacement.isEmpty) {
        return null;
      }

      final List<RecordWeight> list = [];
      if (talent.replacement.grade.isNotEmpty) {
        for (var targetTalent in talents.getAll()) {
          if (!talent.replacement.grade.containsKey(targetTalent.grade)) {
            continue;
          }
          if (exclusive(tIds, targetTalent.id) != null) continue;
          list.add((
            key: targetTalent.id,
            weight: talent.replacement.grade[targetTalent.grade]!,
          ));
        }
      }

      if (talent.replacement.talent.isNotEmpty) {
        for (var id in talent.replacement.talent.keys) {
          if (exclusive(tIds, id) != null) continue;
          list.add((
            key: id,
            weight: talent.replacement.talent[id]!,
          ));
        }
      }

      return list;
    }

    // 最终得出要替换的id
    int innerReplace(int tId, List<int> tIds) {
      final replaceList = getReplaceList(tId, tIds);
      if (replaceList == null) return tId;
      final id = weightRandom(replaceList);
      return innerReplace(
        id,
        List.from(tIds)..add(id),
      );
    }

    final List<int> newTalentIds = List.from(talentIds);
    final Map<int, int> result = {};
    for (var talentId in talentIds) {
      final replaceId = innerReplace(talentId, newTalentIds);
      if (replaceId != talentId) {
        result[talentId] = replaceId;
        newTalentIds.add(replaceId);
      }
    }
    return result;
  }

  // 替换天赋
  (List<int>, List<(Talent, Talent)>) doReplace(List<int> talentIds) {
    final result = replace(talentIds);
    return (
      [...talentIds, ...result.values],
      result.entries
          .map((e) => (
                talents.get(e.key), // 旧天赋
                talents.get(e.value), // 新天赋
              ))
          .toList(),
    );
  }
}
