import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/theme_provider.dart';

// ignore: must_be_immutable
class MonthlyDataTable extends StatelessWidget {
  MonthlyDataTable({Key? key, required this.title, this.date = 'Unknow Date'})
      : super(key: key);
  String title;
  String? date;

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ThemeProvider>();
    return Stack(
      clipBehavior: Clip.none,
      children: [
        //table container
        Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          color: Theme.of(context).secondaryHeaderColor,
          elevation: 10,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),

              // color: Theme.of(context).secondaryHeaderColor,
              color: mode.isDarkMode
                  ? Theme.of(context).secondaryHeaderColor.withOpacity(0.8)
                  : Theme.of(context).secondaryHeaderColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 22.0, bottom: 40),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingTextStyle: Theme.of(context).textTheme.subtitle1,
                  showBottomBorder: true,
                  columnSpacing: 30,
                  columns: _tableColumns,
                  rows: const [
                    DataRow(
                      cells: [
                        DataCell(
                          Center(child: Text('1A')),
                        ),
                        DataCell(
                          Center(child: Text('30433')),
                        ),

                        DataCell(
                          Center(child: Text('310')),
                        ),
                        DataCell(
                          Center(
                            child: SizedBox(
                              width: 100,
                              child: Text(
                                'আশরাফ জামিল',
                                maxLines: 2,
                                overflow: TextOverflow.fade,
                                softWrap: true,
                              ),
                            ),
                          ),
                        ),

                        //phone num
                        DataCell(
                          Center(
                            child: Text('01202223892'),
                          ),
                          showEditIcon: true,
                        ),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(
                          Center(child: Text('1A')),
                        ),
                        DataCell(
                          Center(child: Text('30433')),
                        ),

                        DataCell(
                          Center(child: Text('310')),
                        ),
                        DataCell(
                          Center(
                            child: SizedBox(
                              width: 100,
                              child: Text(
                                'মনজরুল আলম ',
                                maxLines: 2,
                                overflow: TextOverflow.fade,
                                softWrap: true,
                              ),
                            ),
                          ),
                        ),

                        //phone num
                        DataCell(
                          Center(
                            child: Text('01202223892'),
                          ),
                          showEditIcon: true,
                        ),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(
                          Center(child: Text('1A')),
                        ),
                        DataCell(
                          Center(child: Text('30433')),
                        ),

                        DataCell(
                          Center(child: Text('310')),
                        ),
                        DataCell(
                          Center(
                            child: SizedBox(
                              width: 100,
                              child: Text(
                                'দিদার হোসেন ',
                                maxLines: 2,
                                overflow: TextOverflow.fade,
                                softWrap: true,
                              ),
                            ),
                          ),
                        ),

                        //phone num
                        DataCell(
                          Center(
                            child: Text('01202223892'),
                          ),
                          showEditIcon: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: -14,
          left: 10,
          //title container
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),

                ///color: Theme.of(context).primaryColor,
                color: mode.isDarkMode
                    ? Colors.grey.shade800
                    : Theme.of(context).secondaryHeaderColor,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(-1, 1),
                    color: Colors.black.withOpacity(0.7),
                    blurRadius: 1,
                  )
                ]),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(title, style: Theme.of(context).textTheme.subtitle1),
          ),
        ),

        //date and downloadbuttons
        Positioned(
          right: 10,
          top: 10,
          child: Text(date!),
        ),
        Positioned(
          bottom: 3,
          right: 3,
          child: IconButton(
            iconSize: 30,
            onPressed: () {},
            //icon: Image.asset(AppIcons().downloadUrl),
            icon: Icon(
              color: Colors.black.withOpacity(0.8),
              Icons.file_download_outlined,
            ),
          ),
        )
      ],
    );
  }

  final List<DataColumn> _tableColumns = const [
    DataColumn(label: Text('ফ্ল্যাট')),
    DataColumn(label: Text('বুঝে পেয়েছি')),
    DataColumn(label: Text('বকেয়া')),
    DataColumn(label: Text('গ্রাহকের নাম')),
    DataColumn(label: Text('ফোন নম্বর')),
  ];
}
