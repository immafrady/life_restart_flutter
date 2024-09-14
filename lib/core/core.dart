import 'package:flutter/cupertino.dart';
import 'package:life_restart/core/property/property.dart';
import 'package:life_restart/core/sources.dart';
import 'package:life_restart/core/types.dart';

import 'dict/age.dart';
import 'dict/data_dict.dart';
import 'dict/event.dart';
import 'dict/talent.dart';

// 其实就是原项目的Life类
class CoreDelegate extends ChangeNotifier {
  bool isReady = false;
  final Sources _sources = Sources();

  late final DataDict<Event> eventDict; // 事件
  late final DataDict<Talent> talentDict; // 天赋
  late final DataDict<Age> ageDict; // 天赋

  late final PropertyController propertyController; // 属性？

  // 加载
  initialize() async {
    if (!_sources.isLoaded) {
      await _sources.load();
    }
    
    eventDict = DataDict.fromJson(
        _sources.data[FileType.events] as JSONMap, Event.fromJson);
    talentDict = DataDict.fromJson(
        _sources.data[FileType.talents] as JSONMap, Talent.fromJson);
    ageDict = DataDict.fromJson(
        _sources.data[FileType.ages] as JSONMap, Age.fromJson);

    propertyController = PropertyController();
    isReady = true;
    notifyListeners();
  }

  startNewLife() {}
}
