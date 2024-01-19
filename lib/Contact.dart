import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'AppThemes.dart';
import 'ErrorCard.dart';
import 'mycustomappbar.dart';


class Contactpage extends StatelessWidget {
  Contactpage({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Kontakt', scaffoldKey: scaffoldKey),
      drawer: MyDrawer(),
      body: Container(
        color: Colors.grey[100],
        child: buildContactList(),
      ),
    );
  }

  Widget buildContactList() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchContacts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: CenteredErrorCard(errorCode: "Api Request failed"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("No data available"));
        } else {
          List<Map<String, dynamic>> contacts = snapshot.data!;
          return SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: contacts.map((contact) {
                  return Column(
                    children: [
                      buildContactCard(contact),
                      const SizedBox(height: 5),
                    ],
                  );
                }).toList(),
              ),
            ),
          );
        }
      },
    );
  }

  Future<List<Map<String, dynamic>>> fetchContacts() async {
    final response = await http.get(
      Uri.parse('http://localhost:8080/Contactforms'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> list = json.decode(response.body);

      List<Map<String, dynamic>> contacts = list
          .map((item) => Map<String, dynamic>.from(item as Map<String, dynamic>))
          .toList();

      return contacts;
    } else {
      throw Exception('Failed to load contacts');
    }
  }

  Widget buildContactCard(Map<String, dynamic> contact) {
  return Card(
    color: Colors.white,
    elevation: 0, // Erhöhe den elevation-Wert für einen weicheren Schatten
    margin: const EdgeInsets.all(20), // Beispielhafter Rand um die Karte
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10), // Beispielhafter Wert für die abgerundeten Ecken
    ),
    child: Padding(
     
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          buildAvatar(contact['imagePath'] ?? ''),
          const SizedBox(height: 10),
          buildContactName(contact['name'] ?? ''),
          const SizedBox(height: 5),
          buildContactDetails(
            contact['position'] ?? '',
            contact['phone'] ?? '',
            contact['email'] ?? '',
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


  Widget buildAvatar(String imagePath) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        ClipOval(
          child: Container(
            width: 80,
            height: 80,
            color: AppColors.SecondaryBlue,
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
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget buildContactDetails(String position, String phone, String email) {
    return Text(
      '$position \n $phone \n $email',
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.black,
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
          fillColor: AppColors.SecondaryGrey,
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
      backgroundColor: AppColors.Primaryblue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Ändere den Radius hier nach Bedarf
      ),
    ),
    child: const Text(
      'Kontakt Aufnehmen',
      style: TextStyle(color: Colors.white),
    ),
  );
}
}