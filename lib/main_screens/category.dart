import 'package:flutter/material.dart';
import 'package:multi_store_app/categories/accessories_categ.dart';
import 'package:multi_store_app/categories/bags_categ.dart';
import 'package:multi_store_app/categories/beauty_categ.dart';
import 'package:multi_store_app/categories/electronics_categ.dart';
import 'package:multi_store_app/categories/homegarden_categ.dart';
import 'package:multi_store_app/categories/kids_categ.dart';
import 'package:multi_store_app/categories/men_catag.dart';
import 'package:multi_store_app/categories/shoes_categ.dart';
import 'package:multi_store_app/categories/women_categ.dart';
import 'package:multi_store_app/widgets/fake_search.dart';

List<ItemsData> items = [
  ItemsData(label: 'men'),
  ItemsData(label: 'women'),
  ItemsData(label: 'shoes'),
  ItemsData(label: 'bags'),
  ItemsData(label: 'electronics'),
  ItemsData(label: 'accessories'),
  ItemsData(label: 'home & garden'),
  ItemsData(label: 'kids'),
  ItemsData(label: 'beauty')
];

List<Widget> pages = [
  const MenCategory(),
  const WomenCategory(),
  const ShoesCategory(),
  const BagsCategory(),
  const ElectronicsCategory(),
  const AccessoriesCategory(),
  const HomeAndGarden(),
  const KidsCategory(),
  const BeautyCategory(),
];

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final PageController _pageController = PageController();
  @override
  void initState() {
    super.initState();
    items
        .map(
          (element) => element.isSelected = false,
        )
        .toList();

    setState(() {
      items[0].isSelected =
          true; // when we move to the screen it set the initial content first index
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const FakeSearch(),
      ),
      body: Stack(
        children: [
          Positioned(bottom: 0, left: 0, child: sideNavigator(width, height)),
          Positioned(bottom: 0, right: 0, child: categoryView(width, height)),
        ],
      ),
    );
  }

  Widget sideNavigator(double width, double height) {
    return SizedBox(
      height: height * 0.8,
      width: width * 0.2,
      child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.bounceInOut,
                ); // use to move to page we are in page view
                // items
                //     .map(
                //       (element) => element.isSelected = false,
                //     )
                //     .toList();
                // for (var element in items) {
                //   element.isSelected = false;
                // }
                setState(() {
                  items[index].isSelected = true;
                });
              },
              child: Container(
                color: items[index].isSelected
                    ? Colors.white
                    : Colors.grey.shade300,
                height: 100,
                child: Center(
                  child: Text(items[index].label),
                ),
              ),
            );
          }),
    );
  }

  Widget categoryView(double width, double height) {
    return Container(
      height: height * 0.8,
      width: width * 0.8,
      color: Colors.white,
      child: PageView(
          controller: _pageController,
          onPageChanged: ((value) {
            items
                .map(
                  (element) => element.isSelected = false,
                )
                .toList();

            setState(() {
              items[value].isSelected = true;
            });
          }),
          scrollDirection: Axis.vertical,
          children: List.generate(9, (index) => pages[index])),
    );
  }
}

class ItemsData {
  String label;
  bool isSelected;
  ItemsData({required this.label, this.isSelected = false});
}
