import 'package:flutter/material.dart';
import 'package:life_restart/core/core.dart';
import 'package:life_restart/core/dict/talent.dart';
import 'package:life_restart/screens/talent_point/screen.dart';
import 'package:life_restart/stores/player.dart';
import 'package:life_restart/widgets/my_material_banner/widget.dart';
import 'package:life_restart/widgets/talent_list/widget.dart';
import 'package:provider/provider.dart';

import '../../widgets/my_app_bar/widget.dart';

enum Mode { superMode, viewMode, normalMode }

class TalentSelectScreen extends StatefulWidget {
  TalentSelectScreen.superMode({super.key})
      : max = -1,
        mode = Mode.superMode,
        totalPoint = 30 {
    fetchTalents = (CoreDelegate core) => core.talentManager.sortedTalents;
  }

  TalentSelectScreen.normalMode({super.key})
      : max = 3,
        mode = Mode.normalMode,
        totalPoint = 20 {
    fetchTalents = (CoreDelegate core) => core.talentManager.pick10RandomTalents(null);
  }

  TalentSelectScreen.viewMode({super.key})
      : max = -1,
        mode = Mode.viewMode,
        totalPoint = 0;

  final Mode mode;
  final int max;
  final int totalPoint;
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
      _talentPool = widget.fetchTalents(Provider.of<CoreDelegate>(context, listen: false));
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: TalentListWidget(
                  selectedIds: _selectedIds,
                  talentPool: _talentPool,
                  onSelect: (int id) {
                    setState(() {
                      // 操作id的主逻辑
                      if (_selectedIds.contains(id)) {
                        // 删除
                        _selectedIds.remove(id);
                      } else {
                        if (widget.max > 0 && _selectedIds.length >= widget.max) {
                          // 超了
                          MyMaterialBanner.of(context).showMessage(
                            '最多只能选择${widget.max}个天赋',
                            type: AlertType.warning,
                          );
                        } else {
                          final core = Provider.of<CoreDelegate>(context, listen: false);
                          final exclusiveId = core.talentManager.exclusive(_selectedIds.toList(), id);
                          if (exclusiveId is int) {
                            // 冲突了
                            final exclusiveTalent = core.dictStore.talents.get(exclusiveId);
                            final selectedTalent = core.dictStore.talents.get(id);
                            MyMaterialBanner.of(context).showMessage(
                              '【${selectedTalent.name}】和已选天赋【${exclusiveTalent.name}】冲突',
                              type: AlertType.warning,
                            );
                          } else {
                            _selectedIds.add(id);
                          }
                        }
                      }
                    });
                  }),
            ),
            if (widget.mode != Mode.viewMode) // 有判断
              Padding(
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
                        icon: const Icon(Icons.restart_alt),
                        label: const Text("换一换"),
                      ),
                      const SizedBox(width: 20),
                    ],
                    FilledButton.icon(
                      onPressed: () {
                        if (_selectedIds.isEmpty) {
                          MyMaterialBanner.of(context).showMessage(
                            '请选择至少一个天赋',
                            type: AlertType.error,
                          );
                        } else {
                          if (widget.max > 0 && _selectedIds.length != widget.max) {
                            // 最大值超过0才需要判定天赋有没有选够
                            MyMaterialBanner.of(context).showMessage(
                              '请选择${widget.max}个天赋, 当前已选择${_selectedIds.length}个',
                              type: AlertType.error,
                            );
                          } else {
                            Provider.of<PlayerStore>(context, listen: false).talentIds = _selectedIds.toList();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => TalentPointScreen(
                                  initPoint: widget.totalPoint,
                                ),
                              ),
                            );
                          }
                        }
                      },
                      icon: const Icon(Icons.arrow_right_alt),
                      label: const Text("下一步"),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
