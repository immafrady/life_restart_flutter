import 'dart:convert';

import 'package:flutter/services.dart';

typedef Data = Map<String, dynamic>;

class Sources {
  Sources._();

  // 单例
  static final Sources _instance = Sources._();

  factory Sources() {
    return _instance;
  }

  Map<FileType, Data> data = {
    FileType.ages: {},
    FileType.events: {},
    FileType.talents: {},
  };

  Data ages = {};
  Data events = {};
  Data talents = {};
  bool isLoaded = false;

  Future<Data> _loadJsonFromAssets(String fileName) async {
    String jsonString =
        await rootBundle.loadString('assets/data/$fileName.json');
    return jsonDecode(jsonString);
  }

  initialize() async {
    for (var v in FileType.values) {
      data[v] = await _loadJsonFromAssets(v.keyPath);
    }
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
