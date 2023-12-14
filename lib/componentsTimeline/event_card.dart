import "package:flutter/material.dart";


class EventCard extends StatelessWidget {
  String? country;
  String? eventName;
  int? year;

  String? placement;
  String? title;
  String? tags;

  String? content;
  String? imagePath;
  


  EventCard(this.country, this.eventName, this.year, this.placement, this.title, this.tags, this.content, this.imagePath,{
    super.key,
  });

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //LEFT SIDE
          Expanded ( 
            flex:2,
            child : Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //LAND TURNIER JAHR
                  Text("$country $eventName $year", style: const TextStyle(color: Colors.grey, fontSize: 10,) ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("$placement", style: const TextStyle(fontSize: 19,)),
                      Text("$eventName"),
                    ],
                  ),
                  
                  Text("$tags", style: const TextStyle(color: Colors.grey, fontSize: 10, backgroundColor: Color.fromARGB(255, 243, 243, 243),) ),
                ]
              ),
            ),
          ),

          //RIGHT SIDE
          if (imagePath != null)
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  imagePath!,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

