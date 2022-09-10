import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweet_home/models/home_summary.dart';
import 'package:sweet_home/models/response.dart';

import '../../models/home_model.dart';

class HomeCrud {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Response response = Response();
  CollectionReference getHomesCollectionRef() {
    return _db
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('homes');
  }

  //DELETE HOME
  Response deleteHome(String homeId) {
    getHomesCollectionRef().doc(homeId).delete().whenComplete(() {
      response.code = 200;
      response.body = 'home deleted';
    }).catchError((e) {
      response.code = 400;
      response.body = e.toString();
    });
    return response;
  }

  //RETURN CURRENT USERS HOMES
  Stream<List<HomeSummary>> getHome() async* {
    CollectionReference homeCollectionRef = getHomesCollectionRef();
    QuerySnapshot snapshot = await homeCollectionRef.get();
    yield snapshot.docs.map((home) {
      return HomeSummary.fromJson(home.data() as Map<String, dynamic>);
    }).toList();
  }

  Future<List<Home>> getAllHome() async {
    final homeSnapshots = await getHomesCollectionRef().get();
    List<Home> allHome = homeSnapshots.docs.map((homeDoc) {
      return Home.fromJson(homeDoc.data() as Map<String, dynamic>);
    }).toList();
    return allHome;
  }

  //GET SINGLE HOME
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

  //CREATE NEW HOME
  Future<Response> addHome(
      {String? userId,
      required String homeName,
      required double rentAmount,
      required String location,
      required int numOfFloor,
      required int flatPerFloor,
      double? gasBill,
      double? waterBill}) async {
    //!make user id requried later
    //convert given data to map
    // Map<String, dynamic> data = {
    //   'Home Name': homeName,
    //   'Location': location,
    //   'Rent Amount': rentAmount,
    //   'Gas Bill': gasBill ?? 0,
    //   'Water Bill': waterBill ?? 0
    // };

    CollectionReference users = _db.collection('users');
    DocumentReference docReferencer = users.doc(_auth.currentUser!.uid);
    DocumentReference homeDocRef =
        docReferencer.collection('homes').doc(); //auto generated doc id
    //adding new home to the collection

    //converting data to map
    final data = Home(
      homeId: homeDocRef.id, //auto generated doc id
      homeName: homeName,
      rentAmount: rentAmount,
      floor: numOfFloor,
      flatPerFloor: flatPerFloor,
      location: location,
      gasBill: gasBill,
      waterBill: waterBill,
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
