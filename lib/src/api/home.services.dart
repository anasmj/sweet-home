import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweet_home/src/model/flat.dart';
import 'package:sweet_home/src/model/response.dart';

import '../model/home.dart';

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
  Future<List<Home>?> getAllHomes() async {
    try {
      final homeSnapshots = await getHomesCollectionRef().get();
      return homeSnapshots.docs.map((homeDoc) {
        return HomeExtension.fromJson(homeDoc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      return null;
    }
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
  Future<Response> updateHomeField({
    required String homeId,
    required String field,
    required dynamic newValue,
  }) async {
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
  Future<Response> addHome({required Home home}) async {
    //adding new home to the collection
    CollectionReference users = _db.collection('users');
    DocumentReference docReferencer = users.doc(_auth.currentUser!.uid);
    DocumentReference homeDocRef =
        docReferencer.collection('homes').doc(); //home doc created

    //create flats colection, where doc id = flat name
    CollectionReference flatCollectionRef = homeDocRef.collection('flats');
    final flatNames = home.getFlatsAsList(
      floorRange: home.floor!,
      flatRange: home.flatPerFloor!,
    );
    for (var flatName in flatNames) {
      flatCollectionRef.doc(flatName).set(
            Flat().toJson(
              flatName: flatName,
              rentAmount: home.rentAmount ?? 0,
              gasBill: home.gasBill ?? 0,
              waterBill: home.waterBill ?? 0,
            ),
          );
    }

    final data = home.copyWith(homeId: homeDocRef.id);
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
