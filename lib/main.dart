import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metflix/utils/custom_page_route.dart';
import 'package:metflix/views/main_screen.dart';
import 'package:metflix/views/movIe_details_screen.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MetFlix',
      theme: themeData,
      home: MainScreen(),
      //onGenerateRoute: (settings) {
      //  switch (settings.name) {
      //    case MainScreen.route:
      //      return MaterialPageRoute(builder: (_) => MainScreen());
      //    default:
      //      print(settings.name);
      //      List<String> splited = settings.name?.split('/') ?? [];
      //      return splited.length > 1 && (splited[1] == MovieDetailScreen.route)
      //          ? CustomPageRoute.verticalTransition(MovieDetailScreen())
      //          : null;
      //  }
      //},
    );
  }
}

final themeData = ThemeData(
    timePickerTheme: TimePickerThemeData(
      backgroundColor: Colors.blueGrey[700],
    ),
    colorScheme: ColorScheme.dark(
        primary: Color(0xFF6FC9CF),
        surface: Color(0xFF3A3A3A),
        primaryVariant: Color(0x86FFFFFF)),
    canvasColor: Colors.blueAccent[800],
    brightness: Brightness.dark,
    primaryColor: Colors.grey[800],
    primaryColorDark: Colors.white,
    dialogTheme: DialogTheme(backgroundColor: Colors.blueGrey[700]),
    scaffoldBackgroundColor: Color(0xFF000A0F),
    appBarTheme: AppBarTheme(
        elevation: 0,
        color: Color(0x7E000000),
        brightness: Brightness.dark,
        titleTextStyle: TextStyle(
            color: Colors.blueGrey[100],
            fontWeight: FontWeight.w400,
            shadows: [
              Shadow(
                color: Color(0x50000000),
                offset: Offset(1, 1),
                blurRadius: 10,
              ),
            ],
            fontSize: 27)),
    inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
      color: Color(0xFFB9B9B9),
    )),
    textSelectionTheme: TextSelectionThemeData(cursorColor: Color(0xFFB8709C)),
    textTheme: TextTheme(
      headline1: TextStyle(
          fontSize: 72.0,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(220, 220, 220, 1)),
      headline5: TextStyle(
          color: Color(0xFFE4E4E4), fontWeight: FontWeight.w400, fontSize: 20),
      bodyText1: TextStyle(
          fontSize: 14.0,
          fontFamily: 'Hind',
          color: Color.fromRGBO(220, 220, 220, 1)),
      bodyText2: TextStyle(
          fontSize: 14.0,
          fontFamily: 'Hind',
          color: Color.fromRGBO(220, 220, 220, 1)),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        unselectedIconTheme: IconThemeData(color: Colors.grey[200]),
        unselectedItemColor: Colors.grey[200],
        selectedIconTheme: IconThemeData(color: Color(0xFF6ECFD6)),
        selectedItemColor: Colors.blueGrey[600]),
    dividerTheme: DividerThemeData(
        color: Colors.grey[600], indent: 15, endIndent: 15, space: 0),
    iconTheme: IconThemeData(color: Colors.white),
    sliderTheme: SliderThemeData(
        thumbColor: Colors.grey[400],
        overlayColor: Colors.transparent,
        activeTrackColor: Colors.blueGrey[500],
        inactiveTrackColor: Colors.grey[400]),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          textStyle: MaterialStateProperty.all<TextStyle>(
              TextStyle(color: Color(0xFFFFFFFF)))),
    ),
    buttonTheme: ButtonThemeData(
        padding: const EdgeInsets.all(0),
        textTheme: ButtonTextTheme.normal,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap));
