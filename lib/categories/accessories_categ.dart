import 'package:flutter/material.dart';
import 'package:multi_store_app/utilities/categ_list.dart';
import 'package:multi_store_app/widgets/components/categories_body.dart';

class AccessoriesCategory extends StatelessWidget {
  const AccessoriesCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CategoriesBody(
      headerLabel: 'Accessories',
      mainCategoryName: 'accessories',
      tagName: accessories,
      imageName: 'accessories',
    );
  }
}
