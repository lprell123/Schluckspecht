import 'package:flutter/material.dart';
import 'package:schluckspecht_app/Adminform/Feedpostform.dart';
import 'package:schluckspecht_app/AppThemes.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            roundedIconButton(
              icon: Icons.home,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FeedPostForm()),
                );
              },
            ),
            Text("Feedpost"),
            SizedBox(height: 16.0), // Spacer
            roundedIconButton(
              icon: Icons.contact_page_rounded,
              onPressed: () {
                // Navigate to Timelinepost page
              },
            ),
            Text("Kontakteintrag"),
            SizedBox(height: 16.0), // Spacer
            roundedIconButton(
              icon: Icons.work_history,
              onPressed: () {
                // Navigate to Historypost page
              },
            ),
            Text("Historieneintrag"),
          ],
        ),
      ),
    );
  }

  Widget roundedIconButton({required IconData icon, required VoidCallback onPressed}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Material(
        color: AppColors.primaryBlue,
        child: InkWell(
          onTap: onPressed,
          child: Container(
            width: 100,
            height: 100,
            child: Icon(icon, size: 50, color: Colors.white),
          ),
        ),
      ),
    );
  }
}