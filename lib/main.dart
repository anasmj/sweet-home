import 'package:flutter/material.dart';
import 'package:rent_home/screens/home_screen/home_screen.dart';
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
        //primarySwatch: const Color.fromARGB(255, 148, 196, 236),
        primaryColor: Colors.black,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.black),
        appBarTheme: const AppBarTheme(
          color: Color.fromARGB(255, 161, 239, 253),
        ),
      ),
      home: const HomePage(),
    );
  }

  initApp(BuildContext context) async {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }
}

class TextWidget extends StatefulWidget {
  const TextWidget({super.key});

  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        color: Colors.grey,
        height: 400,
        child: Column(
          children: [
            Row(
              children: const [
                SizedBox(
                  width: 100,
                  child: Text(
                    '123 noth caroline dfak kajsdkf uji',
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Spacer(),
                Text('2 July 2022\n Tuesday'),
              ],
            ),
            const Text(
              'ধীমান চক্রবর্তী',
              style: TextStyle(fontSize: 24),
            )
          ],
        ),
      ),
    ));
  }
}
