import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_home/pages/home_page/home_page.dart';
import 'package:rent_home/providers/home_provider.dart';
import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(
        //   create: (context) => Database(),
        // ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
      ],
      child: MaterialApp(
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
        // initialRoute: '/',
        // routes: {
        //   '/': (context) => HomePage(),
        //   '/flat_details_page': (context) => FlatDetails(),
        // },

        home: const HomePage(),
      ),
    );
  }

  initApp(BuildContext context) async {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }
}
