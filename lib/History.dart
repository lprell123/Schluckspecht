import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import "package:schluckspecht_app/componentsTimeline/my_timeline_tile.dart";
import 'package:schluckspecht_app/main.dart';
import 'package:flutter/services.dart' as rootBundle;

class Historypage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var statevalue = appState.selectedpage;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 247, 247),
      appBar: AppBar(title: Text("History"),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: FutureBuilder(
          future: ReadJsonData(),
          builder: (context, data) {
            if(data.hasError) {
              return Center(child: Text("${data.error}"));
            }
            else if (data.hasData) {
              var items = data.data as List<Events>;
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) {
                          return FullText(event: items[index]);
                        },
                      ));
                    },
                    child: MyTimelineTile(
                      items[index].id, 
                      items[index].day,
                      items[index].month, 
                      items[index].year, 
                      items[index].country, 
                      items[index].eventName, 
                      items[index].placement, 
                      items[index].title, 
                      items[index].tags, 
                      items[index].content, 
                      items[index].imagePath,
                    ),
                  );
                  
                },
              );
            }
            else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      )
    );
  }

}

Future<List<Events>>ReadJsonData() async{
  final jsondata = await rootBundle.rootBundle.loadString('assets/events.json');
  final list = json.decode(jsondata) as List<dynamic>;

  return list.map((e) => Events.fromJson(e)).toList();
}

class Events{
  int? id;

  int? day;
  int? month;
  int? year;

  String? country;
  String? eventName;

  String? placement;
  String? title;
  String? tags;

  String? content;
  String? imagePath;
  

  Events(
    {
      this.id, 
      this.day,
      this.month,
      this.year,
      this.country,
      this.eventName,
      this.placement,
      this.title, 
      this.tags,
      this.content,
      this.imagePath,
    }
   );
  
  Events.fromJson(Map<String,dynamic> json)
  {
    id=json['id'];

    day=json['day'];
    month=json['month'];
    year=json['year'];

    country=json['country'];
    eventName=json['event'];

    placement=json['placement'];
    title=json['title'];
    tags=json['tags'];  

    content=json['content'];
    imagePath=json['imagePath'];
  }
}

class FullText extends StatelessWidget {
  final Events event;

  int? day;
  int? month;
  int? year;

  FullText({
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    day = event.day;
    month = event.month;
    year = event.year;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  //DATUM
                  Text(
                    "$day / $month / $year",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),

              //HEADING
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //PLATZIERUNG
                  Text(
                    event.placement ?? "",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.visible,
                  ),

                  //TITEL
                  Text(
                    event.title ?? "",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 131, 131, 131),
                    ),
                    overflow: TextOverflow.visible,
                  ),
                ],
              ),


              const SizedBox(height: 16),
              if (event.imagePath != null)
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset(
                    event.imagePath!,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Text(
                  event.content ?? "",
                  style: TextStyle(fontSize: 18),
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

