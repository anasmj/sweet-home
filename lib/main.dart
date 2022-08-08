import 'package:flutter/material.dart';
import 'package:rent_home/pages/flat_details_page/flat_details.dart';
import 'package:rent_home/pages/home_page/home_page.dart';
import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initApp(context);

    return MaterialApp(
      title: 'Houser Rent',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        secondaryHeaderColor: Colors.cyan[100],

        // colorScheme: ColorScheme.fromSwatch().copyWith(
        //   primary: Color(0xFF61defa),
        //   //secondary: Color(0xff95d7e6),
        // )

        // primaryColor: Colors.black,
        //textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.black),
        // appBarTheme: const AppBarTheme(
        //   color: Color.fromARGB(255, 161, 239, 253),
        // ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/flat_details_page': (context) => const FlatDetails(),
      },
      // home: const FlatDetails(),
    );
  }

  initApp(BuildContext context) async {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }
}
