import 'package:flutter/material.dart';
import 'package:life_restart/widgets/my_app_bar/widget.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(
        title: '人生总结',
      ),
      body: Text('hellow world'),
    );
  }
}
