import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/model/renter.dart';

final newRenterProvider =
    NotifierProvider<NewRenterProvider, Renter>(NewRenterProvider.new);

class NewRenterProvider extends Notifier<Renter> {
  final List<String> occupationOptions = ['চাকরিজীবি', 'ব্যাবসায়ী', 'অন্যান্য'];
  bool isCompleted = false;
  bool isLoading = false;
  bool includeAdvance = false;
  String? advance;
  @override
  Renter build() => Renter(
        occupation: occupationOptions.first,
        numOfPerson: 1,
        entryDate: DateTime.now(),
      );

  Future<void> addRenter({required String homeId}) async {}

  String? onNameChanged(String? s) => state.renterName = s;
  String? onPhoneChanged(String? s) => state.phone = s;
  String? onPhone2Changed(String? s) => state.phone2 = s;
  String? onAddressChanged(String? s) => state.previousAddress = s;
  String? onPermanentAddressChanged(String? s) => state.permanentAddress = s;
  String? onAdvanceChanged(String? s) => advance = s;

  void increaseMember() =>
      state = state.copyWith(numOfPerson: state.numOfPerson! + 1);

  void decreaseMember() {
    if (state.numOfPerson! <= 1) return;
    state = state.copyWith(numOfPerson: state.numOfPerson! - 1);
  }

  void setAdvance(bool? v) {
    includeAdvance = v!;
    ref.notifyListeners();
  }

  void setOccupation(String? s) => state = state.copyWith(occupation: s);

  void setEntryDate(DateTime dt) => state = state.copyWith(entryDate: dt);
}
