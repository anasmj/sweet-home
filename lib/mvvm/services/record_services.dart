import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';
import 'package:sweet_home/mvvm/models/record.dart';
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
    required dynamic value,
    required DateTime datetime,
  }) async {
    String recordDocId = Formatter().makeId(date: datetime);
    final recordCollectionRef =
        await getRecordCollectionRef(homeId: homeId, flatName: flatName);
    await recordCollectionRef
        .doc(recordDocId)
        .update({fieldName: value}).whenComplete(() {
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
  Future<Response> readMonthlyRecord({
    required String homeId,
    required String flatName,
    required String idMonth,
  }) async {
    late Record monthlyRecord;
    final recordCollecRef =
        await getRecordCollectionRef(homeId: homeId, flatName: flatName);
    DocumentReference monthyRecordDocRef = recordCollecRef.doc(idMonth);
    await monthyRecordDocRef.get().then((data) {
      if (data.exists) {
        monthlyRecord = Record.fromJson(data.data() as Map<String, dynamic>);
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

  Future<Response> fetchRecord({
    required String homeId,
    required String flatName,
    required String idMonth,
  }) async {
    final recordCollecRef =
        await getRecordCollectionRef(homeId: homeId, flatName: flatName);
    DocumentReference monthyRecordDocRef = recordCollecRef.doc(idMonth);
    await monthyRecordDocRef.get().then((snapshot) {
      if (snapshot.exists) {
        response.content =
            Record.fromJson(snapshot.data() as Map<String, dynamic>);
        response.code = 200;
      } else {
        response.code = 201;
        response.body = 'not exists';
      }
    }).catchError((e) {
      response.code = 301;
      response.body = e.toString();
    });
    return response;
  }

  //CREATE RECORD INTO FLAT IF NOT EXISTS
  Future<bool> createMonthlyRecord({
    required String homeId,
    required String flatId,
    required Record record,
    required String monthID,
    required DateTime issueDate,
    // required double meterReading,
    // required double renterPayable,
    // Renter? renter,
  }) async {
    bool isSuccess = false;
    CollectionReference recordCollectionRef =
        await getRecordCollectionRef(homeId: homeId, flatName: flatId);

    //create record if not exists
    recordCollectionRef.limit(1).get().then((snapshot) {
      if (snapshot.size == 0) {
        //create new collection

        recordCollectionRef.doc(monthID).set(record.toJson()).whenComplete(() {
          isSuccess = true;
        }).catchError((e) {
          isSuccess = false;
        });
      } else {
        //collection already exists
      }
    });

    // recordCollectionRef.doc(dateId).get().then((docSnapshot) {
    //   // if (!docSnapshot.exists) {}
    //   recordCollectionRef.doc(dateId).set(record.toJson());
    //   recordCollectionRef.doc(dateId).set(MonthlyRecord(
    //         issueDate: issueDate,
    //         rentAmount: flat.flatRentAmount,
    //         meterReading: meterReading,
    //         renterPayable: renterPayable,
    //         // usedElectricityUnit: 200,
    //         gasBill: flat.flatGasBill,
    //         waterBill: flat.flatWaterBill,
    //         renter: flat.renter,
    //       ).toJson());
    //   response.code = 200;
    //   response.body = 'Record created Successfully';
    // }).catchError((e) {
    //   response.code = 300;
    //   response.body = e.toString();
    // });
    return isSuccess;
  }
}
