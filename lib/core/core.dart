import 'package:flutter/cupertino.dart';
import 'package:life_restart/core/functions/util.dart';

import 'dict/dict.dart';
import 'dict/event.dart';
import 'dict/talent.dart';
import 'manager/event.dart';
import 'manager/talent.dart';
import 'property/property.dart';
import 'sources.dart';
import 'types.dart';

// 其实就是原项目的Life类
class CoreDelegate extends ChangeNotifier {
  bool isReady = false;
  final Sources _sources = Sources();

  DictStore get dictStore => _sources.dictStore; // 总字典
  late final EventManager eventManager;
  late final TalentManager talentManager;

  late final PropertyController propertyController; // 属性？

  // 游戏进程相关
  final Map<int, int> talentTriggerCountMap = {}; // 触发天赋统计 <id, count>
  // 加载
  initialize() async {
    if (!_sources.isLoaded) {
      await _sources.load();
    }
    eventManager = EventManager(events: dictStore.events);
    talentManager = TalentManager(talents: dictStore.talents);

    propertyController = PropertyController(ages: dictStore.ages);
    isReady = true;
    notifyListeners();
  }

  // 获取天赋触发次数
  getTalentTriggerCount(int talentId) {
    return talentTriggerCountMap[talentId] ?? 0;
  }

  // 重置游戏进程
  resetGameProcess() {
    talentTriggerCountMap.clear();
  }

  // 开始游戏
  start({required AttributeMap attributes, List<int>? talentIds}) {
    resetGameProcess();
    final (newTalentIds, replaceInfo) = talentManager.doReplace(talentIds ?? []);
    // 替换id
    propertyController.restart(
      attributes: {
        ...attributes,
        PropertyKey.spirit: 5, // 默认快乐 5
        PropertyKey.life: 1, // 默认生命 1
      },
      relations: {PropertyKey.talent: newTalentIds},
    );
    applyTalent();
    notifyListeners();
    return replaceInfo;
  }

  // 应用天赋
  List<Talent> applyTalent({List<int>? replaceTalentIds}) {
    if (replaceTalentIds != null) {
      propertyController.person.change(PropertyKey.talent, replaceTalentIds);
    }

    final allowTalentIds = propertyController.person
        .getRelation(PropertyKey.talent)
        .where((id) => getTalentTriggerCount(id) < talentManager.talents.get(id).maxTrigger);

    final List<Talent> talentContents = [];
    for (final allowTalentId in allowTalentIds) {
      final result = talentManager.apply(allowTalentId, propertyController.person);
      if (result == null) continue; // 没变化，下一个
      talentTriggerCountMap[allowTalentId] = getTalentTriggerCount(allowTalentId) + 1; // 触发次数+1
      propertyController.applyEffect(result.effect); // 应用
      talentContents.add(result);
    }
    return talentContents;
  }

  // 应用事件
  List<Event> applyEvent({required List<RecordWeight> events}) {
    final allowEvents = events.where((event) => eventManager.check(event.key, propertyController.person)).toList();
    final chosenEventId = weightRandom(allowEvents);

    List<Event> innerApply(int eventId) {
      final (:event, :nextId) = eventManager.apply(eventId, propertyController.person);
      propertyController.person.change(PropertyKey.event, event.id);
      propertyController.applyEffect(event.effect);
      if (nextId != null) {
        return [event, ...innerApply(nextId)];
      } else {
        return [event];
      }
    }

    return innerApply(chosenEventId);
  }

  next() {
    final ageInfo = propertyController.ageNext();
    final talent = applyTalent(replaceTalentIds: ageInfo.talentIds);
    final event = applyEvent(events: ageInfo.events);
    return propertyController.record.add(
      person: propertyController.person,
      talent: talent,
      event: event,
    );
  }
}
