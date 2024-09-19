import 'package:flutter/material.dart';
import 'package:life_restart/core/core.dart';
import 'package:life_restart/widgets/talent_list/widget.dart';
import 'package:provider/provider.dart';

import '../../widgets/my_app_bar/widget.dart';

class TalentSelectScreen extends StatefulWidget {
  const TalentSelectScreen({super.key});

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
                  talentPool: Provider.of<CoreDelegate>(context)
                      .talentManager
                      .sortedTalents,
                  max: 3),
            ),
          ],
        ),
      ),
    );
  }
}
