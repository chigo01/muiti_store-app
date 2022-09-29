import 'package:flutter/material.dart';

class SliderBar extends StatelessWidget {
  const SliderBar({
    Key? key,
    required this.mainCategoryName,
  }) : super(key: key);

  final String mainCategoryName;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height * 0.8,
      width: width * 0.05,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.brown.withOpacity(0.2),
            borderRadius: BorderRadius.circular(50),
          ),
          child: RotatedBox(
            quarterTurns: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                mainCategoryName == 'beauty'
                    ? const Text('')
                    : const Text('<<', style: style),
                Text(mainCategoryName.toUpperCase(), style: style),
                mainCategoryName == 'men'
                    ? const Text('')
                    : const Text('>>', style: style),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const style = TextStyle(
  color: Colors.brown,
  fontSize: 16,
  fontWeight: FontWeight.w600,
  letterSpacing: 10,
);
