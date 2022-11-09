import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/models/utility.dart';
import '../models/flat_model.dart';
import '../utils/formatter.dart';

class FlatService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Response response = Response();

  //get flats collection
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

  Future<Response> getSingleFlat(
      {required String homeId, required String flatName}) async {
    final collectionRef = await getFlatsCollectionRef(homeId: homeId);
    await collectionRef.doc(flatName).get().then((snapshot) {
      Flat flat = Flat.fromJson(snapshot.data() as Map<String, dynamic>);
      response.code = 200;
      response.body = 'ok';
      response.content = flat;
    }).catchError((e) {
      response.code = 202;
      response.body = e.toString();
    });
    return response;
  }

  Stream<List<Flat>> flatsStream({required String homeId}) {
    return _db
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('homes')
        .doc(homeId)
        .collection('flats')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Flat.fromJson(doc.data());
      }).toList();
    });
  }

  Stream<Flat> selectedFlatSteram(
      {required String homeId, required String flatId}) {
    return _db
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('homes')
        .doc(homeId)
        .collection('flats')
        .doc(flatId)
        .snapshots()
        .map((snapshot) =>
            Flat.fromJson(snapshot.data() as Map<String, dynamic>));
  }

  Future<Response> getAllFlatsForVm({required String homeId}) async {
    // DateTime currentDate = DateTime.now();
    // DateTime lastMonthDate =
    //     DateTime(currentDate.year, currentDate.month - 1, currentDate.day);
    // String previousMonthRecordId = Formatter().makeId(date: lastMonthDate);

    CollectionReference flatsCollectionRef =
        await getFlatsCollectionRef(homeId: homeId);

    final flatsSnapshot = await flatsCollectionRef.get();

    //try: assign last month meter reading to previous reading field in flat document
    try {
      // flatsSnapshot.docs.map((flat) async {
      //   final previousMonthRecordDocRef = await flatsCollectionRef
      //       .doc(flat.get('flatName'))
      //       .collection('records')
      //       .doc(previousMonthRecordId)
      //       .get();

      //   if (previousMonthRecordDocRef.get('meterReading') != null) {
      //     double previousReading =
      //         previousMonthRecordDocRef.get('meterReading') as double;
      //     flatsCollectionRef
      //         .doc(flat.get('flatName'))
      //         .update({'previousMeterReading': previousReading});
      //   }
      // }).toList();
      final flatList = flatsSnapshot.docs.map((flat) {
        return Flat.fromJson(flat.data() as Map<String, dynamic>);
      }).toList();
      response.code = 200;
      response.body = 'ok';
      response.content = flatList;
      // return flatList;
    } catch (e) {
      response.code = 300;
      response.body = e.toString();
    }
    return response;
  }

  Future<List<Flat>> getAllFlats({required String homeId}) async {
    DateTime currentDate = DateTime.now();
    DateTime lastMonthDate =
        DateTime(currentDate.year, currentDate.month - 1, currentDate.day);
    String previousMonthRecordId = Formatter().makeId(date: lastMonthDate);

    CollectionReference flatsCollectionRef =
        await getFlatsCollectionRef(homeId: homeId);

    final flatsSnapshot = await flatsCollectionRef.get();

    //try: assign last month meter reading to previous reading field in flat document
    flatsSnapshot.docs.map((flat) async {
      final previousMonthRecordDocRef = await flatsCollectionRef
          .doc(flat.get('flatName'))
          .collection('records')
          .doc(previousMonthRecordId)
          .get();

      if (previousMonthRecordDocRef.get('meterReading') != null) {
        double previousReading =
            previousMonthRecordDocRef.get('meterReading') as double;
        flatsCollectionRef
            .doc(flat.get('flatName'))
            .update({'previousMeterReading': previousReading});
      }
    }).toList();
    final flatList = flatsSnapshot.docs.map((flat) {
      return Flat.fromJson(flat.data() as Map<String, dynamic>);
    }).toList();

    //assign last two month record from 'records' collection in falt document

    // final previousMonthRecordDocRef = await flatsCollectionRef
    //     .doc(flat.flatName)
    //     .collection('records')
    //     .doc(previousMonthRecordId)
    //     .get();

    // double meterReading =
    //     lastMonthRecordDocSnapshot.get('previousMonthMeterReading') ?? 0;
    // flat.currentMonthMeterReading = meterReading;

    //   if (lastMonthRecordDocSnapshot.exists) {
    //     final pervMeterReading =
    //         lastMonthRecordDocSnapshot.get('meterReading') ?? 0.0;
    //     double reading = double.parse(pervMeterReading.toString());
    //     flat.previousMeterReading = reading;
    //   }
    // });
    return flatList;
  }

  //update flat
  Future<Response> updateFlat({
    required String homeId,
    required String flatName,
    required String fieldName,
    required dynamic newValue,
    DateTime? updateTime,
    bool removeServiceCharge = false,
  }) async {
    CollectionReference flatCollecntionRef =
        await getFlatsCollectionRef(homeId: homeId);
    if (fieldName == 'serviceCharges' && newValue is Utility) {
      //remove service charge
      //! should not be deleted for further modification
      // if (removeServiceCharge) {
      //   ServiceCharge serviceCharge = newValue;

      //   await flatCollecntionRef.doc(flatName).update({
      //     'serviceCharges': FieldValue.arrayRemove([serviceCharge.toJson()])
      //   }).whenComplete(() {
      //     response.code = 200;
      //     response.body = 'successfull';
      //   }).catchError((e) {
      //     response.code = 300;
      //     response.body = e.toString();
      //   });
      // }
      //add service charge
      // await flatCollecntionRef.doc(flatName).update({
      //   'serviceCharges': FieldValue.arrayUnion([newValue.toJson()])
      // }).whenComplete(() {
      //   response.code = 200;
      //   response.body = 'successfull';
      // }).catchError((e) {
      //   response.code = 300;
      //   response.body = e.toString();
      // });
    } else {
      if (updateTime != null) {
        if (fieldName == 'presentMeterReading') {
          await flatCollecntionRef.doc(flatName).update({
            fieldName: newValue,
            'presentMeterReadingUpdateTime': updateTime.toIso8601String(),
          }).whenComplete(() {
            response.code = 200;
            response.body = 'successfull';
          }).catchError((e) {
            response.code = 300;
            response.body = e.toString();
          });
        }
        if (fieldName == 'previousMeterReading') {
          await flatCollecntionRef.doc(flatName).update({
            fieldName: newValue,
            'previousMeterReadingUpdateTime': updateTime.toIso8601String(),
          }).whenComplete(() {
            response.code = 200;
            response.body = 'successfull';
          }).catchError((e) {
            response.code = 300;
            response.body = e.toString();
          });
        }
        if (fieldName == 'monthlyDue') {
          await flatCollecntionRef.doc(flatName).update({
            fieldName: newValue,
            'confirmDate': updateTime.toIso8601String(),
          }).whenComplete(() {
            response.code = 200;
            response.body = 'successfull';
          }).catchError((e) {
            response.code = 300;
            response.body = e.toString();
          });
        }
      }

      await flatCollecntionRef.doc(flatName).update({
        fieldName: newValue,
      }).whenComplete(() {
        response.code = 200;
        response.body = 'successfull';
      }).catchError((e) {
        response.code = 300;
        response.body = e.toString();
      });
    }

    return response;
    //update other field of a flat
  }
}
