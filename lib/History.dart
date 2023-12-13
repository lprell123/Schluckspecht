import 'package:flutter/material.dart';
import "package:schluckspecht_app/componentsTimeline/my_timeline_tile.dart";
import 'package:provider/provider.dart';
import 'main.dart';

class Historypage extends StatefulWidget {
  const Historypage({super.key});

  @override State<Historypage> createState() => _TimeLineState();
}



class _TimeLineState extends State<Historypage> {
  @override Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 247, 247),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListView( 
          children: [
            //START
            MyTimelineTile(
              isFirst: true, 
              isLast: false,
              eventCard: Text("12"),
              dateCard: Text("test"),

            ),
        
            //MIDDLEPARTS
            MyTimelineTile(
              isFirst: false, 
              isLast: false,
              eventCard: Text("23"),
              dateCard: Text("test"),
            ),

            MyTimelineTile(
              isFirst: false, 
              isLast: false,
              eventCard: Text("23"),
              dateCard: Text("test"),
            ),

            MyTimelineTile(
              isFirst: false, 
              isLast: false,
              eventCard: Text("23"),
              dateCard: Text("test"),
            ),

            //END OF TIMELINE
            MyTimelineTile(
              isFirst: false, 
              isLast: true,
              eventCard: Text("34"), 
              dateCard: Text("test"), 
            ),
        
          ],
        ),
      )
    ); 
  }
}
