import 'package:flutter/material.dart';
import 'package:schluckspecht_app/AppThemes.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final GlobalKey<ScaffoldState> scaffoldKey;

  MyAppBar({required this.title, required this.scaffoldKey});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.menu,
                  color: AppColors.primaryBlue,
                  size: 34,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
              SizedBox(width: 2), // Adjust the spacing as needed
              Container(
                width: 50,
                height: 50,
                child: Image.asset(
                  'assets/HOLogo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
          SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          SizedBox(width: 8),
          Container(
            width: 50,
            height: 50,
            child: Image.asset(
              'assets/Logo1.png',
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0, // Remove elevation to make the edges straight
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Set border radius to zero
      ),
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/appbarheaderimage.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Text(
                'Schluckspecht',
                style: GoogleFonts.robotoCondensed(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w900)),
              ),
            ),
            ExpansionTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              children: [
                ListTile(
                  title: Text('Displaymode'),
                  trailing: Switch(
                    value: isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        isDarkMode = value;
                      });
                      // You can handle the light/dark mode change here
                    },
                    activeColor: AppColors.primaryRed, // Color when the switch is ON
                    activeTrackColor: Colors.grey[100], // Color of the track when the switch is ON
                    inactiveThumbColor: AppColors.primaryBlue, // Color of the thumb when the switch is OFF
                    inactiveTrackColor: Colors.grey[100], // Color of the track when the switch is OFF
                  ),
                ),
              ],
            ),

            ListTile(
              leading: Icon(Icons.admin_panel_settings),
              title: Text('Admin Panel'),
              onTap: () {
                // Navigate to the Admin Panel page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminPanelPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AdminPanelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
      ),
      body: Center(
        child: Text('Admin Panel Content'),
      ),
    );
  }
}