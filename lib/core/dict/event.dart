import 'package:life_restart/utils/parsers.dart';

import '../types.dart';
import 'effect.dart';

class Event {
  late final int id;
  late final String description;
  late final String postEvent;
  late EffectMap effect;
  late final bool noRandom;
  late final String include;
  late final String exclude;
  List<(String, int)>? branch;

  Event.fromJson(JSONMap json) {
    id = convertToInt(json['id']);
    description = json['event']; // 取event字段的，转换一下
    noRandom = json['NoRandom'] == null ? false : json['NoRandom'] == 1;
    effect = EffectMap()..parse(json['effect']);
    postEvent = json['postEvent'] ?? '';
    include = json['include'] ?? '';
    exclude = json['exclude'] ?? '';

    if (json.containsKey('branch')) {
      final b = json['branch'] as List<dynamic>;
      branch = b.map((dynamic str) {
        final branches = (str as String).split(':');
        return (branches[0], int.parse(branches[1]));
      }).toList();
    }
  }
}
