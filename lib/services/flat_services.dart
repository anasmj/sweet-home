import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweet_home/models/renter.dart';
import 'package:sweet_home/models/response.dart';

import '../models/flat_model.dart';
import '../models/home_model.dart';

class FlatService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Response response = Response();

  //get flats collection
  Future<CollectionReference> getFlatsCollectionRef(String homeId) async {
    DocumentReference currentUserDocRef =
        _db.collection('users').doc(_auth.currentUser!.uid);
    DocumentReference currentHomeDocRef =
        currentUserDocRef.collection('homes').doc(homeId);
    CollectionReference flatsCollectionRef =
        currentHomeDocRef.collection('flats');
    return flatsCollectionRef;
  }

  Future<List<Flat>> getAllFlats({required String homeId}) async {
    CollectionReference flatsCollectionRef =
        await getFlatsCollectionRef(homeId);
    final flatsSnapshot = await flatsCollectionRef.get();
    final flatList = flatsSnapshot.docs.map((flat) {
      Renter? renter;

      try {
        var renterData = flat['renter'] as Map<String, dynamic>;
        if (renterData.isNotEmpty) {
          renter = Renter.fromJson(renterData);
        }
      } catch (e) {}
      return Flat.fromJson(flat.data() as Map<String, dynamic>);
    }).toList();
    return flatList;
  }

  //GET SINGLE FLAT
  Future<Home?> getFlatById({required String homeId, flatId}) async {
    //READ SINGE FLAT
    CollectionReference flatsCollectionRef =
        await getFlatsCollectionRef(homeId);
    DocumentSnapshot flatsSnapshot = await flatsCollectionRef.doc(flatId).get();
    if (flatsSnapshot.exists) {
      print('snapshot found');
      print(flatsSnapshot.get('flatName'));
    }
  }

  //DELETE FLAT
  // Response deleteHome(String homeId) {
  //   getHomesCollectionRef().doc(homeId).delete().whenComplete(() {
  //     response.code = 200;
  //     response.body = 'home deleted';
  //   }).catchError((e) {
  //     response.code = 400;
  //     response.body = e.toString();
  //   });
  //   return response;
  // }

  //UPDATE FLAT
  // Response updatefield(
  //     {required String homeId,
  //     required String field,
  //     required dynamic newValue}) {
  //   getHomesCollectionRef()
  //       .doc(homeId)
  //       .update({field: newValue}).whenComplete(() {
  //     response.code = 200;
  //     response.body = 'updated successfully';
  //   }).catchError((error) {
  //     response.code = 400;
  //     response.body = 'unable to update';
  //   });
  //   return response;
  // }

  //CREATE NEW FLAT
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
