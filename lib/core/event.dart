import 'effect.dart';
import 'types.dart';

// 事件控制
class EventDictionary {
  final Map<int, Event> _tree = {};

  EventDictionary._();

  factory EventDictionary.fromJson(JSONMap events) {
    final controller = EventDictionary._();
    for (var MapEntry(:key, :value) in events.entries) {
      controller._tree[int.parse(key)] = Event.fromJson(value);
    }
    return controller;
  }

  Event get(int id) {
    return _tree[id]!;
  }
}

class Event {
  final int id;
  final String event;
  late final String postEvent;
  late EffectMap effect;
  late final bool noRandom;
  late final String include;
  late final String exclude;
  List<(String, int)>? branch;

  Event._({required this.id, required this.event, int noRandom = 0})
      : noRandom = noRandom == 0 ? false : true;

  factory Event.fromJson(JSONMap json) {
    final map = EffectMap()..parse(json['effect']);
    final event = Event._(
        id: json['id'], event: json['event'], noRandom: json['NoRandom'] ?? 0)
      ..effect = map // todo 这一块不确定
      ..postEvent = json['postEvent'] ?? ''
      ..include = json['include'] ?? ''
      ..exclude = json['exclude'] ?? '';

    if (json.containsKey('branch')) {
      final branch = json['branch'] as List<dynamic>;
      event.branch = branch.map((dynamic str) {
        final branches = (str as String).split(':');
        return (branches[0], int.parse(branches[1]));
      }).toList();
    }

    return event;
  }
}
