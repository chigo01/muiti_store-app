import 'package:flutter/material.dart';
import 'package:multi_store_app/utilities/categ_list.dart';
import 'package:multi_store_app/widgets/components/categories_body.dart';

class ElectronicsCategory extends StatelessWidget {
  const ElectronicsCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CategoriesBody(
        headerLabel: 'Electronics',
        mainCategoryName: 'electronics',
        tagName: electronics,
        imageName: 'electronics');
  }
}
