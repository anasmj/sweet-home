import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweet_home/models/monthly_record.dart';
import 'package:sweet_home/models/response.dart';
import 'package:sweet_home/utils/custom_date_time_formatter.dart';
import '../models/flat_model.dart';

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

  //READ ALL FLATS
  Future<List<Flat>> getAllFlats({required String homeId}) async {
    DateTime currentDate = DateTime.now();
    DateTime lastMonthDate =
        DateTime(currentDate.year, currentDate.month - 1, currentDate.day);
    String previousMonthRecordId =
        CustomFormatter().makeId(date: lastMonthDate);

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
      final previousReading = previousMonthRecordDocRef.get('meterReading');
      double previousReadingDouble = double.parse(previousReading.toString());
      flatsCollectionRef
          .doc(flat.get('flatName'))
          .update({'previousMeterReading': previousReadingDouble});
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
}
