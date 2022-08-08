import 'package:flutter/material.dart';
import 'package:rent_home/pages/flat_details_page/components/monthly_expence_table.dart';
import 'components/appbar_content.dart';
import 'components/calender_button.dart';
import 'components/electricity_table.dart';
import 'components/input_textfield.dart';
import 'components/others_table.dart';

class FlatDetails extends StatelessWidget {
  const FlatDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBar(
          flexibleSpace: const Padding(
            padding: EdgeInsets.only(top: 50.0, left: 30),
            child: AppBarContent(),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
              width: 150,
              child: InputTextField(),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CalenderButton(),
                const SizedBox(
                  width: 20,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minWidth: MediaQuery.of(context).size.width * 0.5,
                  color: Theme.of(context).secondaryHeaderColor,
                  onPressed: () {},
                  child: Text(
                    'বুঝে পেলাম',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            ),

            //BUTTON
            Row(
              children: [
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Row(
                    children: const [
                      Text('পূর্বের হিসাবসমূহ'),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(Icons.arrow_forward_ios_rounded, size: 16)
                    ],
                  ),
                )
              ],
            ),

            //DATA TABLE

            MonthlyExpenceTable(),
          ],
        ),
      ),
    );
  }
}
