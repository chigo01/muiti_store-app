import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/categ_widget.dart';
import 'package:multi_store_app/widgets/components/category_header_label.dart';
import 'package:multi_store_app/widgets/components/subcateg_model.dart';

class CategoriesBody extends StatelessWidget {
  const CategoriesBody({
    Key? key,
    required this.headerLabel,
    required this.mainCategoryName,
    required this.tagName,
    required this.imageName,
  }) : super(key: key);

  final String headerLabel;
  final String mainCategoryName;
  final List<String> tagName;
  final String imageName;
  // final String menCategoryName;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              height: height * 0.8,
              width: width * 0.75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CategoryHeaderLabel(
                    headerLabel: headerLabel,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.68,
                    child: GridView.count(
                      mainAxisSpacing: 70,
                      crossAxisSpacing: 15,
                      crossAxisCount: 3,
                      children: List.generate(tagName.length, (index) {
                        return SubCategoryModel(
                          mainCategoryName: mainCategoryName,
                          subCategoryLabel: tagName[index],
                          subCategoryName: tagName[index],
                          assetName: 'images/$imageName/$imageName$index.jpg',
                        );
                      }),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: SliderBar(
              mainCategoryName: mainCategoryName,
            ),
          ),
        ],
      ),
    );
  }
}
