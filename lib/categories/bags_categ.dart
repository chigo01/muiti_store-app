import 'package:flutter/material.dart';
import 'package:multi_store_app/utilities/categ_list.dart';
import 'package:multi_store_app/widgets/components/categories_body.dart';

class BagsCategory extends StatelessWidget {
  const BagsCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CategoriesBody(
      headerLabel: 'Bags',
      mainCategoryName: 'bags',
      imageName: 'bags',
      tagName: bags,
    );
  }
}
