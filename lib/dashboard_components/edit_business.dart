import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/components/appbar_widgets.dart';

class EditBusiness extends StatelessWidget {
  const EditBusiness({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const AppBarButton(),
        title: const AppBarTittle(
          title: 'EditBusiness',
        ),
      ),
    );
  }
}
