import 'package:flutter/material.dart';

class YellowButton extends StatelessWidget {
  const YellowButton({
    Key? key,
    required this.width,
    required this.label,
    required this.onPressed,
  }) : super(key: key);
  final double width;
  final String label;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: MediaQuery.of(context).size.width * width,
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.circular(25),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
