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
                  return MyTimelineTile(
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

