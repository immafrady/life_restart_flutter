import '../dict/data_dict.dart';
import '../dict/event.dart';
import '../functions/condition.dart';
import '../property/person.dart';

class EventManager {
  DataDict<Event> events;

  EventManager({required this.events});

  // 判断event是否可用
  bool check(int id, Person person) {
    final event = events.get(id);
    if (event.noRandom) {
      return false;
    }
    if (event.exclude.isNotEmpty && checkCondition(person, event.exclude)) return false;
    if (event.include.isNotEmpty) return checkCondition(person, event.include);
    return true;
  }

  // 执行Event的判断
  ({Event event, int? nextId}) apply(int id, Person person) {
    final event = events.get(id);
    if (event.branch != null) {
      for (var (condition, id) in event.branch!) {
        if (checkCondition(person, condition)) {
          return (event: event, nextId: id);
        }
      }
    }
    return (event: event, nextId: null);
  }
}
