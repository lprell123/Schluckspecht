import "package:flutter/material.dart";

class DateCard extends StatelessWidget {
  final year;
  final dayMonth;
  const DateCard({super.key, required this.year, required this.dayMonth});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("2019"),
          Text("27/08"),
        ],
      ),
    );
  }
}

