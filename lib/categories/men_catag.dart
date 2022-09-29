import 'package:flutter/material.dart';
import 'package:multi_store_app/utilities/categ_list.dart';

import 'package:multi_store_app/widgets/components/categories_body.dart';

class MenCategory extends StatelessWidget {
  const MenCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CategoriesBody(
      headerLabel: 'Men',
      mainCategoryName: 'men',
      tagName: men,
      imageName: 'men',
    );
  }
}
