import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sweet_home/services/firebase_crud.dart';

class TestClass extends StatelessWidget {
  TestClass({super.key});
  final homeConroller = TextEditingController();
  final flatController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: homeConroller,
                      decoration: inputDecoration(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: flatController,
                      decoration: inputDecoration(),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                var response = await FirebaseCrud.addEmoloyee(
                  name: 'Anika',
                  position: 'software engineer',
                  contactNo: 'Gulshan',
                );
                print(response.code);
              },
              child: const Text('Upload'),
            )
          ],
        ));
  }

  void createUser() async {
    final jsonObj = Record(name: 'jade', age: 32, isCriminal: false).toJson();

    final collectionInstance = await FirebaseFirestore.instance
        .collection('user')
        .doc('id2')
        .set(jsonObj);
  }

  InputDecoration inputDecoration() {
    return InputDecoration(
      prefixIconConstraints: const BoxConstraints(
        maxHeight: 18,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class Record {
  int floorRange = 5;
  int flatRange = 6;

  String name;
  int age;
  bool isCriminal;
  Record({required this.name, required this.age, required this.isCriminal});

  Map<String, dynamic> toJson() => {
        'name': name,
        'age': age,
        'isCriminal': isCriminal,
      };
}
