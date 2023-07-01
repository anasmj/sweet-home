import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sweet_home/src/constants/constants.dart';
import 'package:sweet_home/src/model/renter.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      // backgroundColor: isDark ? Colors.grey.shade900 : Colors.blue.shade200,
      radius: 24,
      child: CircleAvatar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        radius: 20,
        child: Image.asset(
          AssetPath.defaultProfileUrl,
          height: 20,
          width: 22,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key, this.renter});
  final Renter? renter;
  @override
  Widget build(BuildContext context) {
    if (renter == null) {
      return const Padding(
        padding: EdgeInsets.only(bottom: 10.0),
        child: Text(
          'খালি আছে',
          style: TextStyle(fontSize: 18),
        ),
      );
    }
    return Builder(
      builder: (context) {
        return ListTile(
          title: Text(
            renter?.renterName ?? '',
            maxLines: 1,
            overflow: TextOverflow.fade,
            softWrap: true,
          ),
          subtitle: renter != null
              ? Text(
                  ' পাবো ৳ -',
                  style: Theme.of(context).textTheme.titleSmall,
                )
              : const SizedBox.shrink(),

          // subtitle: Text(flat.renter != null
          //     ? '${CustomFormatter().monthYear(flat.renter!.entryDate!)} থেকে আছেন'
          //     : ''),
        );
      },
    );
  }
}

class MeterImage extends StatelessWidget {
  final MeterIndicatorType meterIndicatorType;
  const MeterImage({
    required this.meterIndicatorType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isPrevious = meterIndicatorType == MeterIndicatorType.previousReading;
    return AspectRatio(
      aspectRatio: 2 / 0.8,
      child: Center(
        child: SizedBox(
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topRight,
            children: [
              Image.asset(
                AssetPath.meterUrl,
              ),
              Positioned(
                top: -8,
                right: 6,
                child: isPrevious ? getRedCircle() : getPendingCircle(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getPendingCircle() => const CircleAvatar(
        radius: 10,
        backgroundColor: Colors.orange,
        child: Icon(
          FontAwesomeIcons.ellipsis,
          color: Colors.white,
          size: 14,
        ),
      );

  CircleAvatar getRedCircle() {
    return const CircleAvatar(
      radius: 10,
      backgroundColor: Colors.red,
      child: Icon(
        Icons.question_mark_outlined,
        size: 16,
        color: Colors.white,
      ),
    );
  }
}

class FlatOptions extends StatelessWidget {
  const FlatOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: const [
        SizedBox(height: 20),
        ListTile(
          // onTap: () =>
          //     Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          //   return const SelectedFlatDetail();
          // })),
          leading: Icon(
            Icons.info_outline,
            color: Colors.pink,
          ),
          title: Text('ফ্ল্যাটের বিস্তারিত'),
        ),
        ListTile(
          leading: Icon(
            Icons.add,
            color: Colors.blue,
          ),
          title: Text('গ্রাহক যুক্ত'),
        ),
        ListTile(
          leading: Icon(
            Icons.remove_circle_outline_rounded,
            color: Colors.orange,
          ),
          title: Text('গ্রাহক মুছুন'),
        ),
        ListTile(
          leading: Icon(
            Icons.delete_outline_outlined,
            color: Colors.red,
          ),
          title: Text('ফ্ল্যাট ডিলিট'),
        ),
      ],
    );
  }
}
