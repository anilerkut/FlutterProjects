import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  final Widget textChild;
  final VoidCallback onPressedMethod;
  const MyElevatedButton({
    Key? key,
    required this.textChild,
    required this.onPressedMethod,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 280,
      child: ElevatedButton(
        child: textChild,
        onPressed: onPressedMethod,
      ),
    );
  }
}
