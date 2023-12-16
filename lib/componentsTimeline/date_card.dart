import "package:flutter/material.dart";

class DateCard extends StatelessWidget {
  int? day;
  int? month;
  int? year;

  DateCard(this.day, this.month, this.year);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("$year", style: const TextStyle(color: Colors.grey, fontSize: 10,) ),
          Text("$day / $month", style: const TextStyle(color: Color.fromARGB(255, 36, 36, 36), fontSize: 11,) ),
        ],
      ),
    );
  }
}

