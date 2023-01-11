import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Notifictn_wdgt extends StatelessWidget {
  Notifictn_wdgt({
    super.key,
    required this.name,
    required this.data,
    required this.icn,
    this.clr,
  });
  String name;
  String data;
  IconData icn;
  Color? clr;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(blurRadius: 10, color: Color.fromARGB(255, 207, 206, 206))
          ],
        ),
        height: 80.h,
        width: 350.w,
        child: ListTile(
          leading: Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(
              icn,
              color: clr,
              size: 32.sp,
            ),
          ),
          title: Text(name),
          subtitle: Text(data),
        ),
      ),
    );
  }
}
