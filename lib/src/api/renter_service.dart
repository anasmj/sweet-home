import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constants/src/db.fields.dart';
import '../model/renter.dart';
import '../model/response.dart';

class RenterService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Response response = Response();

  //get flats collection first
  Future<CollectionReference> getFlatsCollectionRef({
    required String homeId,
  }) async {
    DocumentReference currentUserDocRef =
        _db.collection('users').doc(_auth.currentUser!.uid);
    DocumentReference currentHomeDocRef =
        currentUserDocRef.collection('homes').doc(homeId);
    CollectionReference flatsCollectionRef =
        currentHomeDocRef.collection('flats');
    return flatsCollectionRef;
  }

  //Create renter in flat
  Future<Response> addRenterToFlat({
    required String homeId,
    required Renter renter,
    required String flatId,
  }) async {
    CollectionReference flatsCollectionRef =
        await getFlatsCollectionRef(homeId: homeId);
    DocumentReference flatDocRef = flatsCollectionRef.doc(flatId);

    await flatDocRef.update({
      FlatField.renter: renter.toJson(),
    }).whenComplete(() {
      response.code = 200;
      response.body = 'successfully added renter to flat';
    }).catchError((e) {
      response.code = 400;
      response.body = e.toString();
    });
    return response;
  }

  //REMOVE RENTR FROM FLAT
  Future<Response> removeRenterFromFlat(
      {required String homeId, required String flatId}) async {
    CollectionReference flatsCollectionRef =
        await getFlatsCollectionRef(homeId: homeId);
    await flatsCollectionRef
        .doc(flatId)
        .update({FlatField.renter: FieldValue.delete()}).whenComplete(() {
      response.code = 200;
      response.body = 'deleted successfully';
    }).catchError((e) {
      response.code = 400;
      response.body = e.toString();
    });

    return response;
  }

  //UPDATE
  Future<Response> updateRenter({
    required String homeId,
    required String flatName,
    required String fieldName,
    required dynamic newValue,
  }) async {
    final flatCollecRef = await getFlatsCollectionRef(homeId: homeId);
    await flatCollecRef
        .doc(flatName)
        .update({'${FlatField.renter}.$fieldName': newValue}).whenComplete(() {
      response.code = 200;
      response.body = 'successful';
    }).catchError((e) {
      response.code = 204;
      response.body = 'failed';
    });
    return response;
  }
}
