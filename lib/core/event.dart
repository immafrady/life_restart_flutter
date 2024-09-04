import 'types.dart';

// 事件控制
class EventController {
  final Map<String, Event> eventTree = {};

  EventController(JSONMap events) {
    for (var MapEntry(:key, :value) in events.entries) {
      eventTree[key] = Event.fromJson(value);
    }
  }
}

class Event {
  final int id;
  final String event;
  String? postEvent;
  EventEffect? effect;
  bool noRandom = false;
  String? include;
  String? exclude;
  List<(String, int)>? branch;

  Event._({required this.id, required this.event, int noRandom = 0})
      : noRandom = noRandom == 0 ? false : true;

  factory Event.fromJson(JSONMap json) {
    final event = Event._(
        id: json['id'], event: json['event'], noRandom: json['NoRandom'] ?? 0)
      ..effect = json['effect'] != null ? EventEffect.fromJson(json) : null
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

// 事件效果
class EventEffect {
  int age = 0;
  int charm = 0;
  int intel = 0;
  int strength = 0;
  int money = 0;
  int spirit = 0;
  int life = 0;

  EventEffect._();

  factory EventEffect.fromJson(JSONMap json) {
    return EventEffect._()
      ..age = json['AGE'] ?? 0
      ..charm = json['CHR'] ?? 0
      ..intel = json['INT'] ?? 0
      ..strength = json['STR'] ?? 0
      ..money = json['MNY'] ?? 0
      ..spirit = json['SPR'] ?? 0
      ..life = json['LIF'] ?? 0;
  }
}
