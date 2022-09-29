import 'package:flutter/material.dart';
import 'package:multi_store_app/minor_screen/search.dart';
import 'package:multi_store_app/utilities/utils.dart';

class FakeSearch extends StatelessWidget {
  const FakeSearch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SearchScreen(),
          ),
        );
      }),
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          border: Border.all(color: UtilColor.yellow, width: 1.4),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Icon(Icons.search, color: UtilColor.grey),
                ),
                Text(
                  'What are you looking for?',
                  style: TextStyle(fontSize: 18, color: UtilColor.grey),
                ),
              ],
            ),
            Container(
              width: 75,
              height: 32,
              decoration: BoxDecoration(
                color: UtilColor.yellow,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(
                  'search',
                  style: TextStyle(fontSize: 16, color: UtilColor.grey),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
