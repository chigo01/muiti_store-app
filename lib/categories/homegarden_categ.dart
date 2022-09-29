import 'package:flutter/material.dart';
import 'package:multi_store_app/utilities/categ_list.dart';
import 'package:multi_store_app/widgets/components/categories_body.dart';

class HomeAndGarden extends StatelessWidget {
  const HomeAndGarden({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CategoriesBody(
      headerLabel: 'Home & Garden',
      mainCategoryName: 'home & garden',
      tagName: homeandgarden,
      imageName: 'home',
    );
  }
}
