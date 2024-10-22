import 'package:flutter/material.dart';
import 'package:life_restart/screens/result/result_list_widget.dart';
import 'package:life_restart/widgets/my_app_bar/widget.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(
        title: '人生总结',
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            ResultListWidget(),
          ],
        ),
      ),
    );
  }
}
