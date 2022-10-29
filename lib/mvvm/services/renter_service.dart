import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweet_home/mvvm/models/transaction.dart';

import '../models/renter.dart';
import '../models/response.dart';

class RenterService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Response response = Response();

  //get flats collection first
  Future<CollectionReference> getFlatsCollectionRef(
      {required String homeId}) async {
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
    required String flatId,
    required String renterName,
    required String phoneNo,
    String? alternatePhoneNo = '',
    String? occupation = ' ',
    required int noOfPerson,
    required DateTime entryDate,
    String? previousLocation,
    String? village,
    String? policeStation,
    String? union,
    String? subDistrict,
    String? district,
    double? advanceAmount,
    int? nIdNumber,
  }) async {
    CollectionReference flatsCollectionRef =
        await getFlatsCollectionRef(homeId: homeId);
    DocumentReference flatDocRef = flatsCollectionRef.doc(flatId);
    RenterTransaction? transaction;
    if (advanceAmount != null) {
      transaction = RenterTransaction(
          paidBy: renterName,
          amount: advanceAmount,
          time: entryDate,
          isAdvance: true);
    }
    await flatDocRef.update({
      'renter': Renter(
        renterName: renterName,
        phoneNo: phoneNo,
        alternatePhoneNo: alternatePhoneNo,
        occupation: occupation,
        numOfPerson: noOfPerson,
        entryDate: entryDate,
        previousLocation: previousLocation,
        village: village,
        policeStation: policeStation,
        union: union,
        subDistrict: subDistrict,
        district: district,
        nIdNumber: nIdNumber,
        //? advance is not added to account due to solvency of further calculation
        // account: advanceAmount ?? 0,
      ).toJson(renterTransaction: transaction),
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
  Future<Response> deleteRenterFromFlat(
      {required String homeId, required String flatId}) async {
    CollectionReference flatsCollectionRef =
        await getFlatsCollectionRef(homeId: homeId);
    await flatsCollectionRef
        .doc(flatId)
        .update({'renter': FieldValue.delete()}).whenComplete(() {
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
        .update({'renter.$fieldName': newValue}).whenComplete(() {
      response.code = 200;
      response.body = 'successful';
    }).catchError((e) {
      response.code = 204;
      response.body = 'failed';
    });
    return response;
  }
}
