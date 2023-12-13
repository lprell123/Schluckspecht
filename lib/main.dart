import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'themes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'navbar.dart';
import 'Contact.dart';

// Hex Color function
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: lightPrimaryColor,
            brightness: Brightness.light,
          ),
          textTheme: TextTheme(
            displayLarge: const TextStyle(
              fontSize: 72,
              fontWeight: FontWeight.bold,
            ),
            titleLarge: GoogleFonts.robotoCondensed(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontStyle: FontStyle.normal,
            ),
            bodyMedium: GoogleFonts.robotoFlex(),
            displaySmall: GoogleFonts.robotoCondensed(),
          ),
        ),
        home: const MyHomePage(),
      ),
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

    var appState = context.watch<MyAppState>();
    var statevalue = appState.selectedpage;

    return LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth >= 750) {
          return const DesktopNavbar();
        } else if (constraints.maxWidth >= 400) {
          return const TabletNavbar();
        } else {
          return const MobileNavbar();
        }
      },
    );
  }
}
