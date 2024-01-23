import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schluckspecht_app/Feed.dart';
import 'package:schluckspecht_app/GetStarted.dart';
import 'error_log.dart';
import 'navbar.dart';
import 'package:provider/provider.dart';
import 'package:schluckspecht_app/AppThemes.dart';
import 'themes.dart';
import 'package:schluckspecht_app/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';



// Hex Color function
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}


void main()  {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ErrorLog()),
      ],
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Schluckspecht',
      color: AppColors.backgroundColor,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.robotoTextTheme().copyWith(
          headline1: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          headline2: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          headline3: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          headline4: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          headline5: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          headline6: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle1: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          subtitle2: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          bodyText1: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          bodyText2: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          button: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          caption: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.normal,
              color: Colors.grey,
            ),
          ),
          overline: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.normal,
              color: Colors.blue,
            ),
          ),
        ),
        cardTheme: CardTheme(
          color: Colors.white,
        ),
      ),

      home: const MyHomePage(),
    );
  }
}


class MyAppState extends ChangeNotifier {
  var selectedpage = 0;
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class OpenMainpage extends StatefulWidget {
  const OpenMainpage({super.key});

  @override
  State<OpenMainpage> createState() => _OpenMainpageState();
}

class _OpenMainpageState extends State<OpenMainpage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 750) {
        return const DesktopNavbar();
      } else if (constraints.maxWidth >= 600) {
        return const TabletNavbar();
      } else {
        return MobileNavbar();
      }
      
    });
    
  }
}


class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

     checkFirstTime().then((isFirstTime) {
      Future.delayed(Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
      });
     });
    
      if(isFirstTime) {
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GetStarted()),
      );
      }
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 750) {
        return const DesktopNavbar();
      } else if (constraints.maxWidth >= 600) {
        return const TabletNavbar();
      } else {
        return isLoading
            ? Container(
              color: Colors.white,
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl: '',
                    placeholder: (context, url) => Image.asset('assets/Preloader.gif'),
                    errorWidget: (context, url, error) => Image.asset('assets/Preloader.gif', width: 200, height: 200,),
                  ),
                ),
              )
            : const MobileNavbar();
      }
    });
  }
}

Future<bool> checkFirstTime() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('firstTime') ?? true;
}

Future<void> setFirstTimeFlag(bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('firstTime', value);
}
