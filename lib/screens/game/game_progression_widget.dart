import 'package:flutter/material.dart';
import 'package:life_restart/core/core.dart';
import 'package:life_restart/core/dict/talent.dart';
import 'package:provider/provider.dart';

class GameProgressionWidget extends StatefulWidget {
  const GameProgressionWidget({super.key, required this.replaceList});

  final List<(Talent, Talent)> replaceList;

  @override
  State<GameProgressionWidget> createState() => _GameProgressionWidgetState();
}

class _GameProgressionWidgetState extends State<GameProgressionWidget> {
  final ScrollController _scrollController = ScrollController();

  // 手动滚动到底部
  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent, // 滚动到底部
      duration: const Duration(milliseconds: 50), // 动画时间
      curve: Curves.easeOut, // 动画效果
    );
  }

  @override
  void didUpdateWidget(covariant GameProgressionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(),
        child: Card.filled(
          elevation: 0.5,
          child: Consumer<CoreDelegate>(builder: (context, core, widget) {
            final list = core.propertyController.record.list;

            return ListView.builder(
              controller: _scrollController,
              itemBuilder: (context, index) {
                final record = list[index];
                final leadingText = record.age >= 100 ? record.age.toString() : '${record.age}岁';

                // 处理天赋相关的渲染列表
                final subtitleRenderList = <String>[];
                if (index == 0 && this.widget.replaceList.isNotEmpty) {
                  subtitleRenderList
                      .addAll(this.widget.replaceList.map((pair) => '天赋【${pair.$1.name}】发动: 替换为天赋【${pair.$2.name}】'));
                }
                subtitleRenderList.addAll(record.talents.map((talent) => '天赋【${talent.name}】发动：${talent.description}'));

                return Card.outlined(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(leadingText),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: record.events
                          .map(
                            (event) => Text(event.description),
                          )
                          .toList(),
                    ),
                    subtitle: subtitleRenderList.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: subtitleRenderList
                                .map(
                                  (text) => Text(text),
                                )
                                .toList(),
                          )
                        : null,
                  ),
                );
              },
              itemCount: list.length,
            );
          }),
        ),
      ),
    );
  }
}
