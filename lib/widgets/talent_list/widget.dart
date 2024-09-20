import 'package:flutter/material.dart';
import 'package:life_restart/core/dict/talent.dart';
import 'package:life_restart/widgets/talent_list/talent_item_widget.dart';

class TalentListWidget extends StatefulWidget {
  const TalentListWidget(
      {super.key,
      required this.talentPool,
      required this.max,
      this.disabled = false});

  final List<Talent> talentPool; // 天赋池
  final int max; // 最多可选的
  final bool disabled;

  @override
  State<StatefulWidget> createState() => _TalentListState();
}

class _TalentListState extends State<TalentListWidget> {
  final Set<int> _selectedIds = {};

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(8),
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 10),
        itemCount: widget.talentPool.length,
        itemBuilder: (BuildContext context, int index) {
          final talent = widget.talentPool[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                if (_selectedIds.contains(talent.id)) {
                  _selectedIds.remove(talent.id);
                } else {
                  _selectedIds.add(talent.id);
                }
              });
            },
            child: TalentItemWidget(
              name: talent.name,
              description: talent.description,
              grade: talent.grade,
              active: _selectedIds.contains(talent.id),
            ),
          );
        });
  }
}
