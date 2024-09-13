import 'package:life_restart/core/types.dart';
import 'package:life_restart/core/utils.dart';
import 'package:life_restart/utils/parsers.dart';

import 'effect.dart';

class TalentController {}

class Talent {
  final int id;
  final String name;
  final String description;
  final int grade;
  late final int maxTrigger; // 从condition中提取
  late final List<int> exclusive; // 数据源中有字符串，需要清洗一下
  late final int status; // 比较少有
  late final String condition;
  late EffectMap effect;
  late final Replacement replacement;

  Talent._({
    required dynamic id,
    required this.name,
    required this.description,
    required this.grade,
  }) : id = convertToInt(id);

  factory Talent.fromJson(JSONMap json) {
    final map = EffectMap()..parse(json['effect']);

    final talent = Talent._(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        grade: json['grade'])
      ..maxTrigger = extractMaxTrigger(json['condition'] ?? '')
      ..status = json['status'] ?? 0
      ..condition = json['condition'] ?? ''
      ..effect = map
      ..replacement = Replacement.fromJson(json['replacement']);

    final exclusive = json['exclusive'];
    if (exclusive != null && exclusive is List) {
      talent.exclusive = exclusive.map((val) => convertToInt(val)).toList();
    } else {
      talent.exclusive = [];
    }

    return talent;
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
      map[convertToInt(value[0])] = convertToInt(value[1], defaultValue: 1);
    }
  }
}
