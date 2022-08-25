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
    CollectionReference _noteCollection = _collection;
    return _noteCollection.snapshots();
  }

  //UPDATE
  static Future<Response> updateEmployee({
    required String name,
    required String position,
    required String contat,
    required String docId,
  }) async {
    DocumentReference documentReferencer = _collection.doc(docId);

    Response response = Response();

    Map<String, dynamic> data = {
      'name': name,
      'position': position,
      'contact': contat,
    };

    await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = 'updated';
    }).catchError((e) {
      response.code = 500;
      response.message = 'occured some problem ';
    });
    return response;
  }
}
