import 'package:flutter/material.dart';
import 'package:multi_store_app/utilities/categ_list.dart';
import 'package:multi_store_app/widgets/components/categories_body.dart';

class KidsCategory extends StatelessWidget {
  const KidsCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CategoriesBody(
        headerLabel: 'Kids',
        mainCategoryName: 'kids',
        tagName: kids,
        imageName: 'kids');
  }
}
