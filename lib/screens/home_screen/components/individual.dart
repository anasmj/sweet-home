import 'package:flutter/material.dart';
import 'package:rent_home/models/dummy_renter.dart';
import '../../user_history/user_history.dart';

class Individual extends StatefulWidget {
  const Individual({
    Key? key,
    required this.renter,
  }) : super(key: key);
  final DummyRenter renter;

  @override
  State<Individual> createState() => _IndividualState();
}

class _IndividualState extends State<Individual> {
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserHistory(renter: widget.renter),
            )),
        child: Card(
          color: Colors.white70,
          child: ListTile(
            leading: CircleAvatar(
              radius: 22.0,
              backgroundColor: widget.renter.isPaid
                  ? Colors.green
                  : const Color.fromARGB(255, 214, 59, 59),
              child: widget.renter.isPaid
                  ? const Icon(Icons.check)
                  : const Text(
                      'pending..',
                      style: TextStyle(
                          fontSize: 8.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5),
                    ),
            ),
            subtitle: Row(
              children: [
                Text(
                  widget.renter.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                widget.renter.isNotified
                    ? const Text(
                        ' (notified)',
                        style: TextStyle(fontSize: 12),
                      )
                    : const Text(''),
              ],
            ),
            title: Row(
              children: [
                Text(widget.renter.floor.toString()),
                Text(widget.renter.flatNo),
              ],
            ),
            trailing: widget.renter.isPaid
                ? const Icon(
                    Icons.notifications,
                    color: Colors.grey,
                    size: 30,
                  )
                : widget.renter.isNotified
                    ? const Icon(
                        Icons.notifications_active,
                        color: Colors.green,
                        size: 30,
                      )
                    : const Icon(
                        Icons.notifications,
                        color: Color.fromARGB(
                            255, 214, 59, 59), //Color.fromARGB(255, 80, 51, 9),
                        size: 30,
                      ),
          ),
        ),
      ),
    );
  }
}
