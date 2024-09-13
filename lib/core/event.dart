import 'effect.dart';
import 'types.dart';

// 事件控制
class EventController {
  final Map<int, Event> eventTree = {};

  EventController(JSONMap events) {
    for (var MapEntry(:key, :value) in events.entries) {
      eventTree[int.parse(key)] = Event.fromJson(value);
    }
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
