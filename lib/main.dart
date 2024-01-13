import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schluckspecht_app/AppThemes.dart';
import 'themes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'navbar.dart';
import 'package:schluckspecht_app/themes.dart';


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


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Schluckspecht',
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


class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth >= 750) {
          return const DesktopNavbar();
        } else if (constraints.maxWidth >= 600) {
          return const TabletNavbar();
        } else {
          return const MobileNavbar();
        }
      },
    );
  }
}
