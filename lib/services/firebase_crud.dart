import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _collection = _firestore.collection('Employee');

class FirebaseCrud {
//CREATE EMPLOYEE RECORD

  static Future<Response> addEmoloyee(
      {required String name,
      required String position,
      required String contactNo}) async {
    Response response = Response();
    DocumentReference documentReferencer = _collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      'employee_name': name,
      'position': position,
      'contact_no': contactNo
    };

    var result = await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = 'Successfully addad to database';
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });
    return response;
  }

  //READ EMPLOYEE DATA
  static Stream<QuerySnapshot> readEmployee() {
    CollectionReference notesItemCollection = _collection;
    return notesItemCollection.snapshots();
  }
}
