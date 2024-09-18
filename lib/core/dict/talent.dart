import 'package:life_restart/utils/parsers.dart';

import '../types.dart';
import '../utils.dart';
import 'effect.dart';

class Talent {
  late final int id;
  late final String name;
  late final String description;
  late final int grade;
  late final int maxTrigger; // 从condition中提取
  late final List<int> exclusive; // 数据源中有字符串，需要清洗一下
  late final int status; // 比较少有 （影响初始分配的总能力值）
  late final String condition;
  late EffectMap effect;
  late final Replacement replacement;

  Talent.fromJson(JSONMap json) {
    final map = EffectMap()..parse(json['effect']);

    id = convertToInt(json['id']);
    name = json['name'];
    description = json['description'];
    grade = json['grade'];
    maxTrigger = extractMaxTrigger(json['condition'] ?? '');
    status = json['status'] ?? 0;
    condition = json['condition'] ?? '';
    effect = map;
    replacement = Replacement.fromJson(json['replacement']);

    final e = json['exclusive'];
    if (e != null && e is List) {
      exclusive = e.map((val) => convertToInt(val)).toList();
    } else {
      exclusive = [];
    }
  }
}

class Replacement {
  late final Map<int, int> grade = {};
  late final Map<int, int> talent = {};

  Replacement._();

  factory Replacement.fromJson(JSONMap? json) {
    final replacement = Replacement._();
    if (json != null) {
      replacement._setter(replacement.grade, json['grade'] ?? []);
      replacement._setter(replacement.talent, json['talent'] ?? []);
    }
    return replacement;
  }

  void _setter(Map<int, int> map, List<dynamic> list) {
    map.clear();
    for (var val in list) {
      var str = val.toString();
      final value = str.split('*');
      map[convertToInt(value[0])] =
          value.length > 1 ? convertToInt(value[1], defaultValue: 1) : 1;
    }
  }
}
