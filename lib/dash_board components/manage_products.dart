import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/components/appbar_widgets.dart';

class ManageProducts extends StatelessWidget {
  const ManageProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTittle(title: 'Manage Products'),
        leading: const AppBarButton(),
      ),
    );
  }
}
