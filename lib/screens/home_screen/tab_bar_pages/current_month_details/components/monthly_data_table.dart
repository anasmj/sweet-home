import 'package:flutter/material.dart';

class MonthlyDataTable extends StatelessWidget {
  MonthlyDataTable({Key? key, required this.title, this.date = 'Unknow Date'})
      : super(key: key);
  String title;
  String? date;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        //table container
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  offset: const Offset(-1, 2),
                  blurRadius: 8,
                  color: Colors.black.withOpacity(0.5)),
            ],
            color: Theme.of(context).secondaryHeaderColor,
          ),
          height: 200,
          width: 400,
        ),
        Positioned(
          top: -14,
          left: 10,
          //title container
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).secondaryHeaderColor,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(-1, 1),
                    color: Colors.black.withOpacity(0.7),
                    blurRadius: 1,
                  )
                ]),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(title),
          ),
        ),
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
}
