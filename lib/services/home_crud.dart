import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweet_home/models/response.dart';

import '../models/home_model.dart';

class HomeCrud {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Response response = Response();

  //GET CURRENT HOME INFO
  void getCurrentHomeInfo() async {
    DocumentReference currentUserDocRef =
        _db.collection('users').doc(_auth.currentUser!.uid);
    CollectionReference userHomeCollection =
        currentUserDocRef.collection('homes');
    DocumentSnapshot homeSnapshot =
        await userHomeCollection.doc('xzxtIiLkYnCPtxDMLi2G').get();
    if (homeSnapshot.exists) {
      // print(homeSnapshot.data());
    }
  }

  //prints current username email etc..
  // void getCurrentHomeInfo() async {
  //   DocumentReference currentUserDocRef =
  //       _db.collection('users').doc(_auth.currentUser!.uid);
  //   DocumentSnapshot snapshot = await currentUserDocRef.get();
  //   if (snapshot.exists) {
  //     print(snapshot.data());
  //   }
  // }

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

    //method chaining
    // _db
    //     .collection('users')
    //     .doc(_auth.currentUser!.uid)
    //     .collection('homes')
    //     .add({
    //   'HomeNmae': 'First Home',
    //   'Rent Amount': 25600,
    //   'Address': 'Dhanmondi',
    //   'Gas Bill': 800,
    //   'Water Bill': 500,
    //   'Electricity': 1200,
    // });

    return response;
  }
}
