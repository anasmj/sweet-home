import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/models/service_charges.dart';

class OtherExpenceService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Response response = Response();

//get doments of a flat
  Future<DocumentReference> getFlatDocRef(
      {required String homeId, required String flatId}) async {
    DocumentReference currentUserDocRef =
        _db.collection('users').doc(_auth.currentUser!.uid);
    DocumentReference currentHomeDocRef =
        currentUserDocRef.collection('homes').doc(homeId);
    CollectionReference flatsCollectionRef =
        currentHomeDocRef.collection('flats');
    DocumentReference flatDocRef = flatsCollectionRef.doc(flatId);
    return flatDocRef;
  }

  //add otherExpence to a flat
  Future<Response> getServiceCharges(
      {required String homeId, required String flatId}) async {
    List<ServiceCharge> serviceChargeList = [];

    final flatDocRef = await getFlatDocRef(homeId: homeId, flatId: flatId);
    await flatDocRef.get().then((flatDocSnapshot) {
      final serviceChargeMap =
          flatDocSnapshot['serviceCharges'] as Map<String, dynamic>;
      try {
        serviceChargeMap.forEach((purposeName, amount) {
          serviceChargeList.add(ServiceCharge(
              purpose: purposeName, amount: double.parse(amount.toString())));
          response.code = 200;
          response.body = 'ok';
          response.content = serviceChargeList;
        });
      } catch (e) {
        response.code = 201;
        response.body = e.toString();
      }
    }).catchError((e) {
      response.code = 202;
      response.body = e.toString();
    });

    return response;
    // print(a.data());
  }
}
