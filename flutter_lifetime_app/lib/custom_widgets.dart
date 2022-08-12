import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final Color renk;
  final Widget? child;
  final Function? onPress;
  MyContainer({this.renk = Colors.white, this.child, this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onPress != null) {
          onPress!();
        }
      },
      child: Container(
        margin: EdgeInsets.all(10),
        child: child,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(10), color: renk),
      ),
    );
  }
}
