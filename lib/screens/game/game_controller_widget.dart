import 'package:flutter/material.dart';
import 'package:life_restart/core/core.dart';
import 'package:life_restart/utils/generate_spaced_children.dart';
import 'package:provider/provider.dart';

enum PlaySpeed {
  play1x(label: '自动播放', duration: 1000),
  play2x(label: '二倍自动', duration: 500),
  skip(label: '光速到头', duration: 0),
  stop(label: '停止自动', duration: -1);

  final String label;
  final int duration;

  const PlaySpeed({required this.label, required this.duration});
}

class GameControllerWidget extends StatelessWidget {
  const GameControllerWidget({super.key, required this.currentSpeed, required this.onSpeedChange});

  final PlaySpeed currentSpeed;
  final Function(PlaySpeed) onSpeedChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 10),
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
                      return FilledButton(
                        onPressed: () {
                          onSpeedChange(PlaySpeed.stop);
                        },
                        child: Text(PlaySpeed.stop.label),
                      );
                    } else {
                      return ElevatedButton(
                        onPressed: () {
                          onSpeedChange(autoPlay);
                        },
                        child: Text(autoPlay.label),
                      );
                    }
                  }).toList()),
            );
          }
        },
      ),
    );
  }
}
