import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/models/service_charges.dart';

class ServiceChargeService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Response response = Response();

  //get home docuemnt
  Future<DocumentReference> getHomeDocRef({required String homeId}) async => _db
      .collection('users')
      .doc(_auth.currentUser!.uid)
      .collection('homes')
      .doc(homeId);

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

  //ADD
  Future<Response> addNweServiceCharge(
      {required String homeId, required ServiceCharge serviceCharge}) async {
    DocumentReference homeDocRef = await getHomeDocRef(homeId: homeId);
    await homeDocRef.update({
      'serviceCharges': FieldValue.arrayUnion([serviceCharge.toJson()])
    }).whenComplete(() {
      response.code = 200;
      response.body = 'ok';
    }).catchError((e) {
      response.code = 300;
      response.body = e.toString();
    });
    return response;
  }

  //UPDATE
  Future<Response> updateServiceCharge(
      {required String homeId,
      required ServiceCharge oldServiceCharge,
      required ServiceCharge newServiceCharge}) async {
    Map<String, dynamic> itemMap;
    try {
      DocumentReference homeDocRef = await getHomeDocRef(homeId: homeId);
      DocumentSnapshot snapshot = await _db
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('homes')
          .doc(homeId)
          .get();
      final serviceChargeList = await snapshot.get('serviceCharges');
      serviceChargeList.forEach((item) {
        itemMap = item as Map<String, dynamic>;
        if (itemMap['purpose'] == newServiceCharge.purpose) {
          homeDocRef.update({
            'serviceCharges':
                FieldValue.arrayRemove([oldServiceCharge.toJson()])
          });
          homeDocRef.update({
            'serviceCharges': FieldValue.arrayUnion([newServiceCharge.toJson()])
          });
        }
      });
      response.code = 200;
      response.body = 'updated';
    } catch (e) {
      response.code = 201;
      response.body = e.toString();
    }
    return response;
  }

  //DELETE
  Future<Response> deleteServiceCharge(
      {required String homeId, ServiceCharge? serviceCharge}) async {
    DocumentReference homeDocRef = await getHomeDocRef(homeId: homeId);
    homeDocRef.update({
      'serviceCharges': FieldValue.arrayRemove([serviceCharge?.toJson()])
    }).whenComplete(() {
      response.code = 200;
      response.body = 'deleted';
    }).catchError((e) {
      response.code = 201;
      response.body = e.toString();
    });
    return response;
  }

  //READ || HOME
  Future<Response> readHomeServiceCharge({
    required String homeId,
  }) async {
    List<ServiceCharge> chargeList = [];
    try {
      DocumentSnapshot snapshot = await _db
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('homes')
          .doc(homeId)
          .get();

      final serviceChargeList = await snapshot.get('serviceCharges');
      if (serviceChargeList.isEmpty) {
        response.code = 200;
        response.body = 'empty list';
        response.content = chargeList;
      } else {
        serviceChargeList.forEach(
          (item) {
            chargeList
                .add(ServiceCharge.fromJson(item as Map<String, dynamic>));
            response.code = 200;
            response.body = 'ok';
            response.content = chargeList;
          },
        );
      }
    } catch (e) {
      response.code = 300;
      response.body = e.toString();
    }
    return response;
  }

  //READ || FLAT
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
