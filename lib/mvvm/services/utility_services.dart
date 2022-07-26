import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/models/utility.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';

class UtilityServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Response response = Response();

  //get home docuemnt
  Future<DocumentReference> getHomeDocRef({required String homeId}) async => _db
      .collection('users')
      .doc(_auth.currentUser!.uid)
      .collection('homes')
      .doc(homeId);

// get doments of a flat
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

  //ADD to home
  Future<Response> addNewUtility(
      {required String homeId, required Utility serviceCharge}) async {
    DocumentReference homeDocRef = await getHomeDocRef(homeId: homeId);
    await homeDocRef.update({
      'utilities': FieldValue.arrayUnion([serviceCharge.toJson()])
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
  Future<Response> updateUtility(
      {required String homeId,
      required Utility oldServiceCharge,
      required Utility newServiceCharge}) async {
    Map<String, dynamic> itemMap;
    try {
      DocumentReference homeDocRef = await getHomeDocRef(homeId: homeId);
      DocumentSnapshot snapshot = await _db
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('homes')
          .doc(homeId)
          .get();
      final serviceChargeList = await snapshot.get('utilities');
      serviceChargeList.forEach((item) {
        itemMap = item as Map<String, dynamic>;
        if (itemMap['purpose'] == newServiceCharge.purpose) {
          homeDocRef.update({
            'utilities': FieldValue.arrayRemove([oldServiceCharge.toJson()])
          });
          homeDocRef.update({
            'utilities': FieldValue.arrayUnion([newServiceCharge.toJson()])
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
  Future<Response> deleteUtility(
      {required String homeId,
      String? flatId,
      required scope,
      required Utility serviceCharge}) async {
    switch (scope) {
      case Scope.home:
        DocumentReference homeDocRef = await getHomeDocRef(homeId: homeId);
        await homeDocRef.update({
          'utilities': FieldValue.arrayRemove([serviceCharge.toJson()])
        }).whenComplete(() {
          response.code = 200;
          response.body = 'deleted';
        }).catchError((e) {
          response.code = 201;
          response.body = e.toString();
        });
        return response;

      case Scope.flat:
        if (flatId == null) break;

        DocumentReference flatDocRef =
            await getFlatDocRef(homeId: homeId, flatId: flatId);
        await flatDocRef.update({
          'utilities': FieldValue.arrayRemove([serviceCharge.toJson()])
        }).whenComplete(() {
          response.code = 200;
          response.body = 'deleted';
        }).catchError((e) {
          response.code = 201;
          response.body = e.toString();
        });

        return response;
    }

    return response;
  }

  //READ || BOTH
  Future<Response> readUtilities({
    required String homeId,
    String? flatId,
    required Scope scope,
  }) async {
    List<Utility> defaultList = [];
    switch (scope) {
      case Scope.home:
        try {
          DocumentSnapshot snapshot = await _db
              .collection('users')
              .doc(_auth.currentUser!.uid)
              .collection('homes')
              .doc(homeId)
              .get();

          final serviceChargeList = await snapshot.get('utilities');
          if (serviceChargeList.isEmpty) {
            response.code = 200;
            response.body = 'empty list';
            response.content = defaultList;
          } else {
            serviceChargeList.forEach(
              (item) {
                defaultList.add(Utility.fromJson(item as Map<String, dynamic>));
                response.code = 200;
                response.body = 'ok';
                response.content = defaultList;
              },
            );
          }
        } catch (e) {
          response.code = 300;
          response.body = e.toString();
        }
        break;
      case Scope.flat:
        if (flatId == null) break;
        try {
          DocumentReference flatDocRef =
              await getFlatDocRef(homeId: homeId, flatId: flatId);
          DocumentSnapshot snapshot = await flatDocRef.get();

          // DocumentSnapshot snapshot = await _db
          //     .collection('users')
          //     .doc(_auth.currentUser!.uid)
          //     .collection('homes')
          //     .doc(homeId)
          //     .collection('flats')
          //     .doc(flatId)
          //     .get();
          final serviceChargeList = await snapshot.get('utilities');
          if (serviceChargeList.isEmpty) {
            response.code = 200;
            response.body = 'empty list';
            response.content = defaultList;
          } else {
            serviceChargeList.forEach(
              (item) {
                defaultList.add(Utility.fromJson(item as Map<String, dynamic>));
                response.code = 200;
                response.body = 'ok';
                response.content = defaultList;
              },
            );
          }
        } catch (e) {
          response.code = 300;
          response.body = e.toString();
        }
        break;
    }
    return response;
  }
  //! home and flat are intigrated
  //READ || HOME
  // Future<Response> readHomeServiceCharge({
  //   required String homeId,
  //   required domain,
  // }) async {
  //   List<ServiceCharge> chargeList = [];
  //   try {
  //     DocumentSnapshot snapshot = await _db
  //         .collection('users')
  //         .doc(_auth.currentUser!.uid)
  //         .collection('homes')
  //         .doc(homeId)
  //         .get();

  //     final serviceChargeList = await snapshot.get('serviceCharges');
  //     if (serviceChargeList.isEmpty) {
  //       response.code = 200;
  //       response.body = 'empty list';
  //       response.content = chargeList;
  //     } else {
  //       serviceChargeList.forEach(
  //         (item) {
  //           chargeList
  //               .add(ServiceCharge.fromJson(item as Map<String, dynamic>));
  //           response.code = 200;
  //           response.body = 'ok';
  //           response.content = chargeList;
  //         },
  //       );
  //     }
  //   } catch (e) {
  //     response.code = 300;
  //     response.body = e.toString();
  //   }
  //   return response;
  // }

  //READ || FLAT
  // Future<Response> getFlatServiceCharges(
  //     {required String homeId, required String flatId}) async {
  //   List<ServiceCharge> serviceChargeList = [];

  //   final flatDocRef = await getFlatDocRef(homeId: homeId, flatId: flatId);
  //   await flatDocRef.get().then((flatDocSnapshot) {
  //     final serviceChargeMap =
  //         flatDocSnapshot['serviceCharges'] as Map<String, dynamic>;
  //     try {
  //       serviceChargeMap.forEach((purposeName, amount) {
  //         serviceChargeList.add(ServiceCharge(
  //             purpose: purposeName, amount: double.parse(amount.toString())));
  //         response.code = 200;
  //         response.body = 'ok';
  //         response.content = serviceChargeList;
  //       });
  //     } catch (e) {
  //       response.code = 201;
  //       response.body = e.toString();
  //     }
  //   }).catchError((e) {
  //     response.code = 202;
  //     response.body = e.toString();
  //   });

  //   return response;
  //   // print(a.data());
  // }
}
