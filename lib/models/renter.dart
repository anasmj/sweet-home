import 'month_details.dart';

class Renter {
  String name, flatNo, id;
  int floor;
  bool isPaid, isNotified;
  List<MonthDetails>? records;
  Renter(
      {this.id = '',
      required this.name,
      required this.floor,
      this.flatNo = '',
      required this.isPaid,
      this.isNotified = false,
      this.records});
}

List<Renter> renters = [
  Renter(
    id: '0',
    name: 'Ashraful Islam',
    floor: 2,
    isNotified: true,
    isPaid: false,
  ),
  Renter(id: '1', name: 'Rafia Sultana', floor: 1, isPaid: true),
  Renter(
    id: '4',
    name: 'Rifat Merhaj',
    floor: 2,
    flatNo: 'A',
    isPaid: false,
    isNotified: false,
  ),
  Renter(id: '3', name: 'Rabiul Alam', floor: 2, flatNo: 'B', isPaid: true),
  Renter(
    id: '5',
    name: 'Monirul  Hoque',
    floor: 3,
    flatNo: 'C',
    isPaid: false,
    isNotified: false,
  ),
  Renter(
    id: '6',
    name: 'Jinia Alam',
    floor: 3,
    flatNo: 'A',
    isPaid: true,
  ),
];
