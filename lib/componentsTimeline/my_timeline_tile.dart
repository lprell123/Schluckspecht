import "package:flutter/material.dart";
import "package:schluckspecht_app/componentsTimeline/event_card.dart";
import "package:schluckspecht_app/componentsTimeline/date_card.dart";
import 'package:timeline_tile/timeline_tile.dart';

class MyTimelineTile extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final eventCard;
  final dateCard;

  const MyTimelineTile({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.eventCard,
    required this.dateCard,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,  

        alignment: TimelineAlign.manual,
        lineXY: 0.20,
        
        //DECORATIONS
        beforeLineStyle: LineStyle(color: Color.fromARGB(255, 121, 121, 121), thickness: 2),
        indicatorStyle: IndicatorStyle(color: Color.fromARGB(255, 121, 121, 121), width: 15),

        startChild: DateCard(
          year: dateCard,
          dayMonth: dateCard,
        ),
        endChild: EventCard(
          child: eventCard,
        ),
      ),
    );
  }
}