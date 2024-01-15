import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:schluckspecht_app/AppThemes.dart';
import 'main.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

class Feedpage extends StatelessWidget {

  Feedpage({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed'),
      ),
      body: FutureBuilder<List<Posts>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            var items = snapshot.data!;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Container(
                 margin: AppCardStyle.innerPadding,
                  child: buildPostCard(context, items[index]),
                   );
                return buildPostCard(context, items[index]);
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget buildPostCard(BuildContext context, Posts post) {
    return Card(
      color: AppColors.cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
            child: Text(
              post.title ?? '',
              style: const TextStyle(
                fontSize: AppTextStyle.largeFontSize,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          if (post.content != null)
            Padding(
              padding: AppCardStyle.innerPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.content!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 8,
                    style: const TextStyle(
                      fontSize: AppTextStyle.regularFontSize,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) {
                          return SecondPage(post: post);
                        },
                      ));
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        'Weiterlesen',
                        style: TextStyle(
                          color: AppColors.primaryFontColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (post.imagePath != null)
            AspectRatio(
              aspectRatio: 3 / 2,
              child: ClipRRect(
                borderRadius: AppCardStyle.cardBorderRadius,
                child: Image.asset(
                  post.imagePath!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

Future<List<Posts>> fetchData() async {
  try {
    return await fetchPostsFromApi();
  } catch (e) {
    print('API request failed. Trying to load local data...');
    return readLocalJson();
  }
}



Future<List<Posts>>readLocalJson() async{
  final jsondata = await rootBundle.rootBundle.loadString('assets/localData/Feed/posts.json');
  final list = json.decode(jsondata) as List<dynamic>;

  return list.map((e) => Posts.fromJson(e)).toList();
}

Future<List<Posts>> fetchPostsFromApi() async {
  try {
    final response = await http.get(Uri.parse('http://localhost:8080/Feedposts'));

    if (response.statusCode == 200) {
      final List<dynamic> list = json.decode(response.body);
      final posts = list.map((e) => Posts.fromJson(e)).toList();

      // Lokale Speicherung der JSON-Daten
      await saveDataLocally(posts);

      return posts;
    } else {
      throw Exception('Failed to load events');
    }
  } catch (e) {
    // Beim Fehler lokale Daten laden, wenn verfügbar
    return getLocalData();
  }
}

Future<void> saveDataLocally(List<Posts> posts) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'posts';
  final value = jsonEncode(posts.map((post) => post.toJson()).toList());
  prefs.setString(key, value);
}

Future<List<Posts>> getLocalData() async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'posts';
  final value = prefs.getString(key);
  if (value != null) {
    final List<dynamic> decoded = jsonDecode(value);
    return decoded.map((e) => Posts.fromJson(e)).toList();
  }
  return [];
}

class Posts{
  int? id;
  String? title;
  String? content;
  String? date;
  String? imagePath;
  String? source;
  

  Posts(
    {
      this.id, 
      this.title, 
      this.content,
      this.date,
      this.imagePath,
      this.source,
    }
   );
  
  Posts.fromJson(Map<String,dynamic> json)
  {
    id=json['id'];
    title=json['title'];
    content=json['content'];
    date=json['date'];
    imagePath=json['imagePath'];
    source=json['source'];
    
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date,
      'imagePath': imagePath,
      'source': source,
    };
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
        padding: AppCardStyle.innerPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: AppCardStyle.innerPadding,
                    child: Text(
                      post.date ?? "",
                      style: const TextStyle(fontSize: AppTextStyle.regularFontSize),
                    ),
                  ),
                ],
              ),
              Text(
                post.title ?? "",
                style: const TextStyle(
                  fontSize: AppTextStyle.titleSize,
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
                style: const TextStyle(fontSize: AppTextStyle.largeFontSize),
                overflow: TextOverflow.visible,
              ),
              const SizedBox(height: 16),
              Text(
                post.source ?? "",
                style: const TextStyle(
                  fontSize: AppTextStyle.smallFontSize,
                  color: AppColors.secondaryFontColor,
                  ),
                  
                overflow: TextOverflow.visible,

              ),
            ],
          ),
        ),
      ),
    );
  }
}
