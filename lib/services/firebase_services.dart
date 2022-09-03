import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sweet_home/models/app_user.dart';
import 'package:sweet_home/views/home_page/components/drawer.dart';
import '../models/response.dart';

// //*SWEET-HOME RELATED CRUD OPERATINS

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _userCollection = _firestore.collection('Users');

class TestFirebase {
  //return all users in 'users'collection
  void readUsers() {
    var printSomething = _userCollection.get();
    print(printSomething);
  }
}
