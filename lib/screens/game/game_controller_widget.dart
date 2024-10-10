import 'package:flutter/material.dart';
import 'package:life_restart/core/core.dart';
import 'package:life_restart/utils/generate_spaced_children.dart';
import 'package:provider/provider.dart';

enum PlaySpeed {
  play1x(tooltip: '自动播放', message: '开始 自动播放 人生', duration: 1000, icon: Icons.play_arrow),
  play2x(tooltip: '二倍自动', message: '开始 二倍速播放 人生', duration: 500, icon: Icons.fast_forward),
  skip(tooltip: '光速到头', message: '立刻跑到结束！', duration: 0, icon: Icons.skip_next),
  stop(tooltip: '停止自动', message: '暂停自动化人生进程', duration: -1, icon: Icons.pause);

  final String tooltip;
  final int duration;
  final IconData icon;
  final String message;

  const PlaySpeed({
    required this.tooltip,
    required this.duration,
    required this.icon,
    required this.message,
  });
}

class GameControllerWidget extends StatelessWidget {
  const GameControllerWidget({
    super.key,
    required this.currentSpeed,
    required this.onSpeedChange,
    required this.onNext,
  });

  final PlaySpeed currentSpeed;
  final Function(PlaySpeed) onSpeedChange;
  final Function() onNext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 10, right: 20, left: 20),
      child: Consumer<CoreDelegate>(
        builder: (context, core, widget) {
          if (core.propertyController.isEnd()) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (context) => ,
                  // ));
                },
                child: const Text('人生总结'),
              ),
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: FilledButton.tonal(
                    onPressed: onNext,
                    child: const Text('前进'),
                  ),
                ),
                const SizedBox(
                  height: 30,
                  child: VerticalDivider(
                    width: 50,
                    thickness: 1,
                  ),
                ),
                Row(
                  children: generateSpacedChildren(
                      spacer: const SizedBox(
                        width: 10,
                      ),
                      children: [
                        PlaySpeed.play1x,
                        PlaySpeed.play2x,
                        PlaySpeed.skip,
                      ].map((autoPlay) {
                        if (autoPlay == currentSpeed) {
                          return IconButton.filledTonal(
                            onPressed: () {
                              onSpeedChange(PlaySpeed.stop);
                            },
                            icon: Icon(PlaySpeed.stop.icon),
                            tooltip: PlaySpeed.stop.tooltip,
                          );
                        } else {
                          return IconButton.outlined(
                            onPressed: () {
                              onSpeedChange(autoPlay);
                            },
                            icon: Icon(autoPlay.icon),
                            tooltip: autoPlay.tooltip,
                          );
                        }
                      }).toList()),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
