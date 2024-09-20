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
                  talentPool:
                      widget.fetchTalents(Provider.of<CoreDelegate>(context)),
                  max: widget.max),
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
                        onPressed: () {},
                        icon: const Icon(Icons.casino),
                        label: const Text("换一换"),
                      ),
                      const SizedBox(width: 20),
                    ],
                    ElevatedButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.start),
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
