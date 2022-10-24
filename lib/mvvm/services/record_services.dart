import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';
import 'package:sweet_home/prev/models/monthly_record.dart';

import '../models/flat_model.dart';
import '../models/response.dart';

class RecordService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Response response = Response();

  //get records collection in a flat
  Future<CollectionReference> getRecordCollectionRef(
      {required String homeId, required String flatName}) async {
    DocumentReference currentUserDocRef =
        _db.collection('users').doc(_auth.currentUser!.uid);
    DocumentReference currentHomeDocRef =
        currentUserDocRef.collection('homes').doc(homeId);
    CollectionReference flatsCollectionRef =
        currentHomeDocRef.collection('flats');
    CollectionReference recordCollectionRef =
        flatsCollectionRef.doc(flatName).collection('records');

    // final recordsSnapshot = await recordCollectionRef.get();
    // print(recordsSnapshot.docs.length);s
    return recordCollectionRef;
  }

  //UPDATE RECORD
  Future<Response> updateRecord({
    required String homeId,
    required String flatName,
    required String fieldName,
    required dynamic newReading,
    required DateTime recordDate,
  }) async {
    String recordDocId = Formatter().makeId(date: recordDate);
    final recordCollectionRef =
        await getRecordCollectionRef(homeId: homeId, flatName: flatName);
    await recordCollectionRef
        .doc(recordDocId)
        .update({fieldName: newReading}).whenComplete(() {
      response.code = 200;
      response.body = 'updated';
    }).catchError((e) {
      response.code = 300;
      response.body = e.toString();
    });
    return response;
  }

  //RECORD IS CREATED FOR EACH FLAT DURING CREATION OF HOME
  //READ A RECORD
  Future<Response> readMonthlyRecord(
      {required String homeId,
      required String flatName,
      required String idMonth}) async {
    late MonthlyRecord monthlyRecord;
    final recordCollecRef =
        await getRecordCollectionRef(homeId: homeId, flatName: flatName);
    DocumentReference monthyRecordDocRef = recordCollecRef.doc(idMonth);
    await monthyRecordDocRef.get().then((data) {
      if (data.exists) {
        monthlyRecord =
            MonthlyRecord.fromJson(data.data() as Map<String, dynamic>);
        response.code = 200;
        response.body = 'record found';
        response.monthlyRecord = monthlyRecord;
      }
    }).catchError((e) {
      response.code = 300;
      response.body = e.toString();
    });

    return response;

    // final docQuerySnap = await docRef.get();
    // print(docQuerySnap.data());
  }

  //CREATE RECORD INTO FLAT IF NOT EXISTS
  Future<Response> createMonthlyRecord({
    required String homeId,
    required Flat flat,
    required DateTime issueDate,
    required double meterReading,
    required double renterPayable,
    // Renter? renter,
  }) async {
    CollectionReference recordCollectionRef =
        await getRecordCollectionRef(homeId: homeId, flatName: flat.flatName);
    String customId = Formatter().makeId(date: issueDate);
    recordCollectionRef.doc(customId).get().then((docSnapshot) {
      // if (!docSnapshot.exists) {}
      recordCollectionRef.doc(customId).set(MonthlyRecord(
            issueDate: issueDate,
            rentAmount: flat.flatRentAmount,
            meterReading: meterReading,
            renterPayable: renterPayable,
            // usedElectricityUnit: 200,
            gasBill: flat.flatGasBill,
            waterBill: flat.flatWaterBill,
            renter: flat.renter,
          ).toJson());
      response.code = 200;
      response.body = 'Record created Successfully';
    }).catchError((e) {
      response.code = 300;
      response.body = e.toString();
    });
    return response;
  }
}
