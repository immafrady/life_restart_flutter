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
  Map<TypeKey, int>? effect;
  bool noRandom = false;
  String? include;
  String? exclude;
  List<(String, int)>? branch;

  Event._({required this.id, required this.event, int noRandom = 0})
      : noRandom = noRandom == 0 ? false : true;

  factory Event.fromJson(JSONMap json) {
    final event = Event._(
        id: json['id'], event: json['event'], noRandom: json['NoRandom'] ?? 0)
      ..effect = Event._parseEffect(json['effect'])
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

  static EffectMap? _parseEffect(JSONMap? json) {
    if (json == null) {
      return null;
    } else {
      final EffectMap map = {};
      for (var MapEntry(:key, :value) in json.entries) {
        final typeKey = TypeKey.parse(key);
        assert(typeKey != null);
        if (typeKey != null) {
          map[typeKey] = value ?? 0;
        } else {
          print('[parse]invalid key: $typeKey');
        }
      }
      return map;
    }
  }
}

typedef EffectMap = Map<TypeKey, int>;
