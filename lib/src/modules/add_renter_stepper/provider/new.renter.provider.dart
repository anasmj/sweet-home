import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/model/renter.dart';

final newRenterProvider =
    NotifierProvider<NewRenterProvider, Renter>(NewRenterProvider.new);

class NewRenterProvider extends Notifier<Renter> {
  final List<String> occupationOptions = ['চাকরিজীবি', 'ব্যাবসায়ী', 'অন্যান্য'];
  bool isCompleted = false;
  bool isLoading = false;
  @override
  Renter build() => Renter();

  Future<void> addRenter({required String homeId}) async {}
  void increaseMember() {}
  void decreaseMember() {}
  void setAdvance(bool? v) {}
  void setOccupation(String? s) {}
  void setEntryDate(DateTime dt) {}
}
