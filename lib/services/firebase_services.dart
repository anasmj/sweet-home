import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/response.dart';

//*SWEET-HOME RELATED CRUD OPERATINS

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _collection = _firestore.collection('Users');

class FirebaseService {
  //ADD HOME
  static Future<Response> addHome(
      {required String homeName, required int numOfFlat}) async {
    Response response = Response();
    DocumentReference documentReferencer = _collection.doc();

    Map<String, dynamic> json = {
      'homeName': homeName,
      'noOfFlat': numOfFlat,
    };

    await documentReferencer.set(json).whenComplete(() {
      response.code = 200;
      response.body = 'Added Successfully';
    }).catchError((e) {
      response.code = 500;
      response.body = e.toString();
    });
    return response;
  }
}
