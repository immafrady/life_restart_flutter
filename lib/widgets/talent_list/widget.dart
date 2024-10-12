import 'package:flutter/material.dart';
import 'package:life_restart/core/dict/talent.dart';
import 'package:life_restart/widgets/talent_list/talent_item_widget.dart';

class TalentListWidget extends StatelessWidget {
  const TalentListWidget(
      {super.key, required this.talentPool, required this.selectedIds, required this.onSelect, this.disabled = false});

  final List<Talent> talentPool; // 天赋池
  final Set<int> selectedIds; // 被选中的id
  final bool disabled;

  final void Function(int) onSelect; // 切换id

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(8),
        itemCount: talentPool.length,
        itemBuilder: (BuildContext context, int index) {
          final talent = talentPool[index];
          return GestureDetector(
            onTap: () {
              onSelect(talent.id);
            },
            child: TalentItemWidget(
              name: talent.name,
              description: talent.description,
              grade: talent.grade,
              active: selectedIds.contains(talent.id),
            ),
          );
        });
  }
}
