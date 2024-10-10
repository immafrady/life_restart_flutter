import 'package:flutter/material.dart';
import 'package:life_restart/core/core.dart';
import 'package:life_restart/core/dict/talent.dart';
import 'package:provider/provider.dart';

class GameProgressionWidget extends StatelessWidget {
  GameProgressionWidget({super.key, required this.replaceList});

  List<(Talent, Talent)> replaceList;

  final ScrollController _scrollController = ScrollController();

  // 手动滚动到底部
  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent, // 滚动到底部
      duration: const Duration(milliseconds: 300), // 动画时间
      curve: Curves.easeOut, // 动画效果
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
        child: Material(
          elevation: 0.5,
          child: Consumer<CoreDelegate>(builder: (context, core, widget) {
            final list = core.propertyController.record.list;
            return ListView.separated(
              controller: _scrollController,
              itemBuilder: (context, index) {
                final record = list[index];
                return Card(
                  child: ListTile(
                    leading: Text(record.age.toString()),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: list.length,
            );
          }),
        ),
      ),
    );
  }
}
