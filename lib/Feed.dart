import 'dart:convert';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'package:flutter/services.dart' as rootBundle;

class Feedpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var statevalue = appState.selectedpage;
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed'),
      ),
      body: FutureBuilder(
        future: ReadJsonData(),
        builder: (context, data) {
          if (data.hasError) {
            return Center(child: Text("${data.error}"));
          } else if (data.hasData) {
            var items = data.data as List<Posts>;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                        child: Text(
                          items[index].title.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (items[index].content != null)
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                items[index].content.toString(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 8,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return SecondPage(post: items[index]);
                                    },
                                  ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    'Weiterlesen',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (items[index].imagePath != null)
                        AspectRatio(
                          aspectRatio: 3 / 2, // Seitenverhältnis etwa 2/3
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              items[index].imagePath!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

Future<List<Posts>>ReadJsonData() async{
  final jsondata = await rootBundle.rootBundle.loadString('assets/posts.json');
  final list = json.decode(jsondata) as List<dynamic>;

  return list.map((e) => Posts.fromJson(e)).toList();
}

class Posts{
  int? id;
  String? title;
  String? content;
  String? date;
  String? imagePath;
  

  Posts(
    {
      this.id, 
      this.title, 
      this.content,
      this.date,
      this.imagePath,
    }
   );
  
  Posts.fromJson(Map<String,dynamic> json)
  {
    id=json['id'];
    title=json['title'];
    content=json['content'];
    date=json['date'];
    imagePath=json['imagePath'];
    
  }



}


class SecondPage extends StatelessWidget {
  final Posts post;

  SecondPage({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      post.date ?? "",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Text(
                post.title ?? "",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.visible,
              ),
              const SizedBox(height: 16),
              if (post.imagePath != null)
                AspectRatio(
                  aspectRatio: 16 / 9, // Verhältnis von Breite zu Höhe. Hier 16:9 als Beispiel.
                  child: Image.asset(
                    post.imagePath!,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 16),
              Text(
                post.content ?? "",
                style: TextStyle(fontSize: 18),
                overflow: TextOverflow.visible,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
