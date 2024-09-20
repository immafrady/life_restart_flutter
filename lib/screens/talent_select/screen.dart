import 'package:flutter/material.dart';
import 'package:life_restart/core/core.dart';
import 'package:life_restart/core/dict/talent.dart';
import 'package:life_restart/widgets/talent_list/widget.dart';
import 'package:provider/provider.dart';

import '../../widgets/my_app_bar/widget.dart';

enum Mode { superMode, viewMode, normalMode }

class TalentSelectScreen extends StatefulWidget {
  TalentSelectScreen.superMode({super.key})
      : max = -1,
        mode = Mode.superMode {
    fetchTalents = (CoreDelegate core) => core.talentManager.sortedTalents;
  }

  TalentSelectScreen.normalMode({super.key})
      : max = 3,
        mode = Mode.normalMode {
    fetchTalents =
        (CoreDelegate core) => core.talentManager.pick10RandomTalents(null);
  }

  TalentSelectScreen.viewMode({super.key})
      : max = -1,
        mode = Mode.viewMode;

  final Mode mode;
  final int max;
  late final List<Talent> Function(CoreDelegate) fetchTalents;

  @override
  State<StatefulWidget> createState() => _TalentSelectState();
}

class _TalentSelectState extends State<TalentSelectScreen> {
  List<Talent> _talentPool = [];
  Set<int> _selectedIds = {};

  updateTalentPool() {
    setState(() {
      _selectedIds = {};
      _talentPool = widget
          .fetchTalents(Provider.of<CoreDelegate>(context, listen: false));
    });
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(updateTalentPool);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: "天赋抽卡",
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: TalentListWidget(
                  selectedIds: _selectedIds,
                  talentPool: _talentPool,
                  onSelect: (int id) {
                    setState(() {
                      if (_selectedIds.contains(id)) {
                        // 删除
                        _selectedIds.remove(id);
                      } else {
                        _selectedIds.add(id);
                      }
                    });
                  }),
            ),
            if (widget.mode != Mode.viewMode) // 有判断
              Container(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 解构了
                    if (widget.mode == Mode.normalMode) ...[
                      ElevatedButton.icon(
                        onPressed: () {
                          updateTalentPool();
                        },
                        icon: const Icon(Icons.casino),
                        label: const Text("换一换"),
                      ),
                      const SizedBox(width: 20),
                    ],
                    ElevatedButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.restart_alt),
                      label: const Text("立刻开始"),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
