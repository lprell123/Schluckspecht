import "package:flutter/material.dart";

class DateCard extends StatelessWidget {
  int? day;
  int? month;
  int? year;

  DateCard(this.day, this.month, this.year);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("$year"),
          Text("$day / $month"),
        ],
      ),
    );
  }
}

