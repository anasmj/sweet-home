import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import '../models/flat_model.dart';
import '../models/home_model.dart';
import '../models/service_charges.dart';

class HomeServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Response response = Response();
  CollectionReference getHomesCollectionRef() {
    return _db
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('homes');
  }

  //READ HOMES
  Future<Response> getAllHomeVM() async {
    try {
      final homeSnapshots = await getHomesCollectionRef().get();
      List<Home> allHome = homeSnapshots.docs.map((homeDoc) {
        return Home.fromJson(homeDoc.data() as Map<String, dynamic>);
      }).toList();
      response.code = 200;
      response.body = 'ok';
      response.content = allHome;
    } catch (e) {
      response.code = 201;
      response.body = e.toString();
    }
    return response;
  }

  Future<List<Home>> getAllHome() async {
    final homeSnapshots = await getHomesCollectionRef().get();
    List<Home> allHome = homeSnapshots.docs.map((homeDoc) {
      return Home.fromJson(homeDoc.data() as Map<String, dynamic>);
    }).toList();

    return allHome;
  }

  //GET SINGLE HOME
  // it doesnt update in real time
  Stream<Home?> getHomeByIdStream({required String homeId}) async* {
    Home? home;
    DocumentReference currentUserDocRef =
        _db.collection('users').doc(_auth.currentUser!.uid);
    CollectionReference userHomeCollection =
        currentUserDocRef.collection('homes');
    DocumentSnapshot homeSnapshot = await userHomeCollection.doc(homeId).get();
    if (homeSnapshot.exists) {
      home = Home.fromJson(homeSnapshot.data() as Map<String, dynamic>);
    }
    yield home;
  }

  //another try to update real time

  Future<Home?> getHomeById({required String homeId}) async {
    DocumentReference currentUserDocRef =
        _db.collection('users').doc(_auth.currentUser!.uid);
    CollectionReference userHomeCollection =
        currentUserDocRef.collection('homes');
    DocumentSnapshot homeSnapshot = await userHomeCollection.doc(homeId).get();
    if (homeSnapshot.exists) {
      return Home.fromJson(homeSnapshot.data() as Map<String, dynamic>);
    }
    return null;
  }

  //DELETE HOME
  Future<Response> deleteHome(String homeId) async {
    await getHomesCollectionRef().doc(homeId).delete().whenComplete(() {
      response.code = 200;
      response.body = 'home deleted';
    }).catchError((e) {
      response.code = 400;
      response.body = e.toString();
    });
    return response;
  }

  //UPDATE HOME
  Future<Response> updateHomeField(
      {required String homeId,
      required String field,
      required dynamic newValue}) async {
    await getHomesCollectionRef()
        .doc(homeId)
        .update({field: newValue}).whenComplete(() {
      response.code = 200;
      response.body = 'updated successfully';
    }).catchError((error) {
      response.code = 400;
      response.body = 'unable to update';
    });
    return response;
  }

  //CREATE NEW HOME
  Future<Response> addHome({
    String? userId,
    required String homeName,
    required double rentAmount,
    required String location,
    required int numOfFloor,
    required int flatPerFloor,
    required List<String> flatNames,
    double? meterReading,
    double? gasBill,
    double? waterBill,
    List<Utility>? utilities,
  }) async {
    //adding new home to the collection
    CollectionReference users = _db.collection('users');
    DocumentReference docReferencer = users.doc(_auth.currentUser!.uid);
    DocumentReference homeDocRef =
        docReferencer.collection('homes').doc(); //home doc created

    //create flats colection, where doc id = flat name
    CollectionReference flatCollectionRef = homeDocRef.collection('flats');
    // ignore: avoid_function_literals_in_foreach_calls
    flatNames.forEach(
      (flatName) => flatCollectionRef.doc(flatName).set(
            Flat().toJson(
              flatName: flatName,
              rentAmount: rentAmount,
              gasBill: gasBill ?? 0.00,
              waterBill: waterBill ?? 0.00,
            ),
          ),
    );

    //CREATING MONTHLY RECORD FOR PREVIOUS MONTH FOR EACH FLAT
    // String previousMonthlRecordId = Formatter().makeId(date: lastMonthDate);
    // String currentMonthlRecordId = CustomFormatter().makeId(date: currentDate);
    // ignore: avoid_function_literals_in_foreach_calls
    // flatNames.forEach((flat) {
    //   //creating record for last month
    //   CollectionReference recordCollectionRef =
    //       flatCollectionRef.doc(flat).collection('records');
    //   recordCollectionRef.doc(previousMonthlRecordId).set(MonthlyRecord(
    //         issueDate: lastMonthDate,
    //         rentAmount: rentAmount,
    //         renterPayable: 0,
    //         meterReading: null,
    //         // usedElectricityUnit: 0.0,
    //         gasBill: gasBill,
    //         waterBill: waterBill,
    //       ).toJson());
    // });
    final data = Home(
      homeId: homeDocRef.id, // assign auto generated doc id to home id
      homeName: homeName,
      rentAmount: rentAmount,
      floor: numOfFloor,
      flatPerFloor: flatPerFloor,
      location: location,
      gasBill: gasBill,
      waterBill: waterBill,
      utilities: utilities ?? [],
    );
    final json = data.toJson();

    await homeDocRef.set(json).whenComplete(() {
      response.code = 200;
      response.body = 'homes collection created';
    }).catchError((e) {
      response.code = 500;
      response.body = e.toString();
    });
    return response;
  }
}
