import 'package:flutter/material.dart';
import 'package:multi_store_app/minor_screen/subcatag_products.dart';

class SubCategoryModel extends StatelessWidget {
  const SubCategoryModel({
    Key? key,
    required this.mainCategoryName,
    required this.subCategoryName,
    required this.assetName,
    required this.subCategoryLabel,
  }) : super(key: key);
  final String mainCategoryName;
  final String subCategoryName;
  final String assetName;
  final String subCategoryLabel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubCategProducts(
              title: subCategoryName,
              maincategName: mainCategoryName,
            ),
          ),
        );
      }),
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              width: 70,
              child: Image(
                image: AssetImage(assetName),
              ),
            ),
          ),
          Expanded(
            child: Text(
              subCategoryLabel,
              style: const TextStyle(fontSize: 11),
            ),
          )
        ],
      ),
    );
  }
}
