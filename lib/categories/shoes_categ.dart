import 'package:flutter/material.dart';
import 'package:multi_store_app/utilities/categ_list.dart';
import 'package:multi_store_app/widgets/components/categories_body.dart';

class ShoesCategory extends StatelessWidget {
  const ShoesCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CategoriesBody(
      headerLabel: 'Shoes',
      mainCategoryName: 'shoes',
      tagName: shoes,
      imageName: 'shoes',
    );
  }
}
