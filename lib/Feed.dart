import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:schluckspecht_app/AppThemes.dart';
import 'package:http/http.dart' as http;

import 'mycustomappbar.dart';

class Feedpage extends StatelessWidget {
  Feedpage({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Feed', scaffoldKey: scaffoldKey),
      drawer: MyDrawer(),
      backgroundColor: Colors.grey[100],
      body: FutureBuilder(
        future: readApiData(),
        builder: (context, data) {
          if (data.hasError) {
            return Center(child: Text("${data.error}"));
          } else if (data.hasData) {
            var items = data.data as List<Posts>;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(20.0),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              // Replace with your user's profile image
                              backgroundImage: AssetImage('assets/Fleig.jpg'),
                              radius: 20.0,
                            ),
                            SizedBox(width: 8.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Unser Team', // Replace with user's name
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '10.12.2023', // Replace with the actual post date
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          items[index].title.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (items[index].imagePath != null)
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              items[index].imagePath!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      if (items[index].content != null)
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            items[index].content.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
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
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Weiterlesen',
                            style: TextStyle(
                              color: AppColors.Primaryblue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
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

Future<List<Posts>> readApiData() async {
  try {
    final response = await http.get(
      Uri.parse('http://localhost:8080/Feedposts'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> list = json.decode(response.body);
      return list.map((e) => Posts.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  } catch (error) {
    print('Error: $error');
    throw error;
  }
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

  const SecondPage({super.key, required this.post});

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
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      post.date ?? "",
                      style: const TextStyle(fontSize: 16),
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
                style: const TextStyle(fontSize: 18),
                overflow: TextOverflow.visible,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
