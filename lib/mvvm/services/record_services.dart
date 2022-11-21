import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<bool> deleteRecord(
      {required String homeId,
      required String flatName,
      required String recordId}) async {
    CollectionReference recordCollectionRef =
        await getRecordCollectionRef(homeId: homeId, flatName: flatName);
    bool result = false;
    await recordCollectionRef
        .doc(recordId)
        .delete()
        .whenComplete(() => result = true)
        .catchError((e) {
      result = false;
    });
    return result;
  }

  //UPDATE
  Future<Response> updateRecord({
    required String homeId,
    required String flatName,
    required Map<String, dynamic> map,
    required DateTime recordDate,
  }) async {
    String recordDocId = Formatter.toYearMonth(recordDate);

    final recordCollectionRef =
        await getRecordCollectionRef(homeId: homeId, flatName: flatName);

    await recordCollectionRef.doc(recordDocId).get().then((snapshot) async {
      if (snapshot.exists) {
        try {
          map.forEach((firebaseField, newValue) async {
            await recordCollectionRef.doc(recordDocId).update({
              firebaseField: newValue,
            });
          });
        } catch (e) {
          response.code = 230;
          response.body = e.toString();
        }
      } else {
        //document does not exists
        response.code = 201;
        response.body = 'no such document exists yet';
      }
    });
    return response;
  }

  //READ ALL
  Future<Iterable<Record>> getAll({
    required String homeId,
    required String flatName,
  }) async {
    Iterable<Record> records = [];
    final recordCollecRef =
        await getRecordCollectionRef(homeId: homeId, flatName: flatName);
    QuerySnapshot recordsSnapshot = await recordCollecRef.get();
    records = recordsSnapshot.docs.map(
        (docSnap) => Record.fromJson(docSnap.data() as Map<String, dynamic>));

    return records;
  }

  //READ SINGLE
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
        //found last month record
        response.content =
            Record.fromJson(snapshot.data() as Map<String, dynamic>);
        response.code = 200;
      } else {
        response.code = 200;
        response.content = null;
      }
    }).catchError((e) {
      response.code = 301;
      response.body = e.toString();
    });
    return response;
  }

  //CREATE IF NOT EXISTS
  Future<bool> createMonthlyRecord({
    required String homeId,
    required String flatId,
    required Record record,
    required String monthID,
    // required double meterReading,
    // required double renterPayable,
    // Renter? renter,
  }) async {
    bool isSuccess = false;
    CollectionReference recordCollectionRef =
        await getRecordCollectionRef(homeId: homeId, flatName: flatId);

    //create record if not exists
    var lastMonthDocument = await recordCollectionRef.doc(monthID).get();
    if (lastMonthDocument.data() != null) return isSuccess;
    await recordCollectionRef
        .doc(monthID)
        .set(record.toJson())
        .whenComplete(() {
      isSuccess = true;
    }).catchError((e) {
      isSuccess = false;
    });
    return isSuccess;
  }
}
