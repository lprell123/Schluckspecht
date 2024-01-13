import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;
import 'AppThemes.dart';
import 'mycustomappbar.dart';




class Contactpage extends StatelessWidget {
  Contactpage({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kontakt'),
      ),
      body: FutureBuilder<List<Contact>>(
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
                  child: buildContactCard(context, items[index]),
                   );
                return buildContactCard(context, items[index]);
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

Widget buildContactCard(BuildContext context, Contact contact) {
  return Card(
    color: AppColors.cardColor,
    elevation: 0, // Erhöhe den elevation-Wert für einen weicheren Schatten
    margin: AppCardStyle.cardMargin, // Beispielhafter Rand um die Karte
    shape: RoundedRectangleBorder(
      borderRadius: AppCardStyle.cardBorderRadius // Beispielhafter Wert für die abgerundeten Ecken
    ),
    child: Padding(
     
      padding: AppCardStyle.innerPadding,
      child: Column(
        children: [
          buildAvatar(contact.imagePath ?? ''),
          const SizedBox(height: 10),
          buildContactName(contact.name ?? ''),
          const SizedBox(height: 5),
          buildContactDetails(
            contact.position ?? '',
            contact.phonenumber ?? '',
            contact.email ?? '',
          ),
          const SizedBox(height: 10),
          buildTextField('Name'),
          const SizedBox(height: 10),
          buildTextField('Betreff'),
          const SizedBox(height: 10),
          buildTextField('Ihre Nachricht'),
          const SizedBox(height: 10),
          buildElevatedButton(),
          const SizedBox(height: 10,)
       ],
      ),
    ),
  );
}
      
    
  

  

Future<List<Contact>> fetchData() async {
  try {
    return await fetchContactsFromApi();
  } catch (e) {
    print('API request failed. Trying to load local data...');
    return readLocalJson();
  }
}


Future<List<Contact>> fetchContactsFromApi() async {
    final response = await http.get(
      Uri.parse('http://localhost:8080/Contactforms'),
    );

    if (response.statusCode == 200) {
    final List<dynamic> list = json.decode(response.body);
    return list.map((e) => Contact.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load events');
  }
  }

  
Future<List<Contact>>readLocalJson() async{
  final jsondata = await rootBundle.rootBundle.loadString('assets/localData/Feed/posts.json');
  final list = json.decode(jsondata) as List<dynamic>;

  return list.map((e) => Contact.fromJson(e)).toList();
}


 

class Contact{
  int? id;
  String? name;
  String? position;
  String? phonenumber;
  String? email;
  String? imagePath;
  

  Contact(
    {
      this.id, 
      this.name, 
      this.position,
      this.phonenumber,
      this.email,
      this.imagePath,
    }
   );
  
  Contact.fromJson(Map<String,dynamic> json)
  {
    id=json['id'];
    name=json['name'];
    position=json['position'];
    phonenumber=json['phonenumber'];
    email=json['email'];
    imagePath=json['imagePath'];
    
  }
}
  


  Widget buildAvatar(String imagePath) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        ClipOval(
          child: Container(
            width: 80,
            height: 80,
            color: AppColors.secondaryBlue,
            child: Image.asset(
              imagePath ?? 'assets/default_image.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget buildContactName(String name) {
    return Text(
      name ?? '',
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: AppTextStyle.regularFontSize,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryFontColor,
      ),
    );
  }

  Widget buildContactDetails(String position, String phonenumber, String email) {
    return Text(
      '$position \n $phonenumber \n $email',
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: AppTextStyle.smallFontSize,
        fontWeight: FontWeight.normal,
        color: AppColors.primaryFontColor,
      ),
    );
  }

  Widget buildTextField(String labelText) {
    return SizedBox(
      width: 250,
      height: labelText == 'Ihre Nachricht' ? 70 : 40,
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.secondaryGrey,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          labelText: labelText,
        ),
      ),
    );
  }

Widget buildElevatedButton() {
  return ElevatedButton(
    onPressed: () {
      // Aktion, die beim Klicken des Buttons ausgeführt werden soll
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryBlue,
      shape: RoundedRectangleBorder(
        borderRadius: AppCardStyle.cardBorderRadius, // Ändere den Radius hier nach Bedarf
      ),
    ),
    child: const Text(
      'Kontakt Aufnehmen',
      style: TextStyle(color: Colors.white),
    ),
  );
}
