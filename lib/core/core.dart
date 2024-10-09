import 'package:flutter/cupertino.dart';

import 'dict/dict.dart';
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

  late final DictStore dictStore; // 总字典
  late final EventManager eventManager;
  late final TalentManager talentManager;

  late final PropertyController propertyController; // 属性？

  final Map<int, int> talentTriggerCountMap = {}; // 触发天赋统计 <id, count>

  // 加载
  initialize() async {
    if (!_sources.isLoaded) {
      await _sources.load();
    }

    dictStore = DictStore.fromJson(source: _sources.data);
    eventManager = EventManager(events: dictStore.events);
    talentManager = TalentManager(talents: dictStore.talents);

    propertyController = PropertyController();
    isReady = true;
    notifyListeners();
  }

  // 获取天赋触发次数
  getTalentTriggerCount(int talentId) {
    return talentTriggerCountMap[talentId] ?? 0;
  }

  // 开始游戏
  start({required AttributeMap attributes, List<int>? talentIds}) {
    talentTriggerCountMap.clear();
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
    propertyController.setRecord();
    notifyListeners();
    return replaceInfo;
  }

  // 应用天赋
  applyTalent({List<int>? replaceTalentIds}) {
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
}
