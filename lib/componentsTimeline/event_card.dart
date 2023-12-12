import "package:flutter/material.dart";


class EventCard extends StatelessWidget {
  final child;
  const EventCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      constraints: const BoxConstraints(
        minHeight: 175,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          //LEFT SIDE
          Expanded ( 
            flex:2,
            child : Container(
              padding: const EdgeInsets.all(10),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //LAND TURNIER JAHR
                  Text(
                    "Frankreich Turnier Cup 2018",
                    style: const TextStyle(color: Colors.grey, fontSize: 6)
                  ),

                  //PLATZIERUNG
                  Text(
                    "3. Platz",
                  ),

                  //
                  Text(
                    "im Bereich autonomes Fahren",
                  ),

                  Text(
                    "#hs_offenburg",
                    style: const TextStyle(color: Colors.grey, fontSize: 6, backgroundColor: Color.fromARGB(255, 243, 243, 243),) 
                  ),
                ],
              ),
            ),
          ),

          //RIGHT SIDE
          Expanded( 
            flex :3,
            child: Container(
              decoration: BoxDecoration(color: const Color.fromARGB(255, 102, 9, 3),),
              
            ),
          )
        ],
      ),
    );
  }
}

