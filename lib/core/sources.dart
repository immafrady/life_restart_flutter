import 'dart:convert';

import 'package:flutter/services.dart';

import 'types.dart';

class Sources {
  Sources._();

  // 单例
  static final Sources _instance = Sources._();

  factory Sources() {
    return _instance;
  }

  Map<FileType, JSONMap> data = {
    FileType.ages: {},
    FileType.events: {},
    FileType.talents: {},
  };

  bool isLoaded = false;

  Future<JSONMap> _loadJsonFromAssets(String fileName) async {
    String jsonString =
        await rootBundle.loadString('assets/data/$fileName.json');
    return jsonDecode(jsonString);
  }

  Future<void> load() async {
    for (var v in FileType.values) {
      data[v] = await _loadJsonFromAssets(v.keyPath);
    }
    isLoaded = true;
  }
}

enum FileType {
  ages('ages'),
  events('events'),
  talents('talents'),
  ;

  final String keyPath;

  const FileType(this.keyPath);
}
