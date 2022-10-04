import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweet_home/prev/models/renter.dart';
import 'package:sweet_home/prev/models/response.dart';
import 'package:sweet_home/prev/models/renter_transaction.dart';

class TransactionService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Response response = Response();

  //get flats collection first
  Future<CollectionReference> getRecordsCollectionRef(
      {required String homeId, required flatId}) async {
    DocumentReference currentUserDocRef =
        _db.collection('users').doc(_auth.currentUser!.uid);
    DocumentReference currentHomeDocRef =
        currentUserDocRef.collection('homes').doc(homeId);
    CollectionReference flatsCollectionRef =
        currentHomeDocRef.collection('flats');
    CollectionReference recordsCollection =
        flatsCollectionRef.doc(flatId).collection('records');
    return recordsCollection;
  }

  //GET LIST OF TRANSACTION OF A RENTER
  Future<List<RenterTransaction?>> readAllTransactionB(
      {required String homeId, required String flatId}) async {
    final recordCollectionRef =
        await getRecordsCollectionRef(homeId: homeId, flatId: flatId);

    final snapShot = await recordCollectionRef.get();
    List<RenterTransaction?> transactionList = [];
    transactionList = snapShot.docs.map((monthDoc) {
      RenterTransaction? transaction;
      Map<String, dynamic> monthMap = monthDoc.data() as Map<String, dynamic>;
      if (monthMap.containsKey('transaction')) {
        transaction = RenterTransaction.fromJson(monthDoc.get('transaction'));
      }
      return transaction;
    }).toList();
    return transactionList;
  }

  //GET LIST OF TRANSACTION OF A RENTER
  Future<List<RenterTransaction>> readAllTransaction(
      {required String homeId, required String flatId}) async {
    List<RenterTransaction> transactionList = [];
    final recordCollectionRef =
        await getRecordsCollectionRef(homeId: homeId, flatId: flatId);
    final snapShot = await recordCollectionRef.get();
    snapShot.docs.forEach((monthDoc) {
      Map<String, dynamic> monthMap = monthDoc.data() as Map<String, dynamic>;
      if (monthMap.containsKey('transaction')) {
        RenterTransaction transaction =
            RenterTransaction.fromJson(monthDoc.get('transaction'));

        transactionList.add(transaction);
      }

      // print(monthDoc.get('renterPayable'));
      // print(monthDoc.get('renter'));
      // print(monthDoc.data());
    });
    return transactionList;
    // print(snapShot.docs.first.data());
  }

  //ADD TRANSACTION IN RECORD
  Future<Response> addTransaction({
    required String homeId,
    required String flatId,
    required String recordId,
    required String paidBy,
    required double amount,
    required DateTime dateTime,
  }) async {
    final recordsCollection =
        await getRecordsCollectionRef(homeId: homeId, flatId: flatId);
    final docRef = recordsCollection.doc(recordId);

    await docRef.update({
      'transaction': RenterTransaction(
        paidBy: paidBy,
        amount: amount,
        time: dateTime,
        // unitConsumed: unitConsumed,
      ).toJson(),
    }).whenComplete(() {
      response.code = 200;
      response.body = 'updated';
    }).catchError((e) {
      response.code = 300;
      response.body = e.toString();
    });
    return response;
  }
}
