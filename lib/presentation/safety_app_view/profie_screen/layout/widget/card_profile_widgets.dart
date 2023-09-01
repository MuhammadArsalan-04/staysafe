import 'package:flutter/material.dart';
import 'package:stay_safe_user/configurations/color_constants.dart';

class CardProfileWidget extends StatelessWidget {
  const CardProfileWidget({required this.widgetsList, super.key});
  final List<Widget> widgetsList;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: widgetsList,
        ),
      ),
    );
  }
}
