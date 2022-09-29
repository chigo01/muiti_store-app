import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/components/appbar_widgets.dart';

class SubCategProducts extends StatelessWidget {
  const SubCategProducts(
      {Key? key, required this.title, required this.maincategName})
      : super(key: key);
  final String title;
  final String maincategName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const AppBarButton(),
        centerTitle: true,
        title: AppBarTittle(title: title),
      ),
      body: Center(
        child: Text(maincategName),
      ),
    );
  }
}
