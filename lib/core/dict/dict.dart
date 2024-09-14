import '../sources.dart';
import '../types.dart';
import 'age.dart';
import 'data_dict.dart';
import 'event.dart';
import 'talent.dart';

class DictStore {
  final DataDict<Age> ages;
  final DataDict<Event> events;
  final DataDict<Talent> talents;

  DictStore.fromJson({required Map<FileType, JSONMap> source})
      : ages = DataDict.fromJson(source[FileType.ages]!, Age.fromJson),
        events = DataDict.fromJson(source[FileType.events]!, Event.fromJson),
        talents = DataDict.fromJson(source[FileType.talents]!, Talent.fromJson);
}
