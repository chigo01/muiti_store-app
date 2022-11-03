import 'package:flutter/material.dart';

import 'package:multi_store_app/widgets/components/appbar_widgets.dart';

class MyStore extends StatelessWidget {
  const MyStore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const AppBarButton(),
        title: const AppBarTittle(
          title: 'MyStore',
        ),
      ),
    );
  }
}
