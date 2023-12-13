import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'AppColors.dart';


class Contactpage extends StatelessWidget {
  final List<Map<String, String>> contacts = [
    {
      'name': 'Fleig, Claus',
      'position': 'CEO',
      'phone': '+49 1704563',
      'email': 'maxmuster@web.de',
      'imagePath': 'assets/Fleig.jpg', // Pfad zum Bild
    },
    {
      'name': 'Hensel, Stefan',
      'position': 'CTO',
      'phone': '+49 1234567',
      'email': 'janedoe@example.com',
      'imagePath': 'assets/Hensel.jpg', // Pfad zum Bild
    },
    {
      'name': 'Jane Doe',
      'position': 'CTO',
      'phone': '+49 1234567',
      'email': 'janedoe@example.com',
      'imagePath': 'assets/Hensel.jpg', // Pfad zum Bild
    },
    // Weitere Kontakte hier hinzufügen...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        color: Colors.grey[100], // Hellgrauer Hintergrund für die gesamte Seite
        child: buildContactList(),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.grey[100],
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Image.asset('assets/HO_Logo_Quer_RGB_pos.png', width: 32, height: 32),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Kontakte',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Image.asset('assets/Fleig.jpg', width: 24, height: 24),
          ),
        ],
      ),
    );
  }

  Widget buildContactList() {
  return SingleChildScrollView(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: contacts.map((contact) {
          return Column(
            children: [
              buildContactCard(contact),
              SizedBox(height: 20), // Hier wird der Abstand zwischen den Cards eingestellt
            ],
          );
        }).toList(),
      ),
    ),
  );
}

  Widget buildContactCard(Map<String, String?> contact) {
  return Card( 
    elevation: 8, // Erhöhe den elevation-Wert für einen weicheren Schatten
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20), // Beispielhafter Rand um die Karte
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10), // Beispielhafter Wert für die abgerundeten Ecken
    ),
    child: Padding(
     
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          buildAvatar(contact['imagePath'] ?? ''),
          SizedBox(height: 10),
          buildContactName(contact['name'] ?? ''),
          SizedBox(height: 5),
          buildContactDetails(
            contact['position'] ?? '',
            contact['phone'] ?? '',
            contact['email'] ?? '',
          ),
          SizedBox(height: 10),
          buildTextField('Name'),
          SizedBox(height: 10),
          buildTextField('Betreff'),
          SizedBox(height: 10),
          buildTextField('Ihre Nachricht'),
          SizedBox(height: 20),
          buildElevatedButton(),
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
        SizedBox(height: 10),
      ],
    );
  }

  Widget buildContactName(String name) {
    return Text(
      name ?? '',
      textAlign: TextAlign.center,
      style: TextStyle(
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
      style: TextStyle(
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
    child: Text(
      'Kontakt Aufnehmen',
      style: TextStyle(color: Colors.white),
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.Primaryblue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Ändere den Radius hier nach Bedarf
      ),
    ),
  );
}
}