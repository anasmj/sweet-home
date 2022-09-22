import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweet_home/models/response.dart';
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
    CollectionReference flatsCollectionRef =
        await getFlatsCollectionRef(homeId: homeId);
    final flatsSnapshot = await flatsCollectionRef.get();
    final flatList = flatsSnapshot.docs.map((flat) {
      return Flat.fromJson(flat.data() as Map<String, dynamic>);
    }).toList();
    return flatList;
  }
}
