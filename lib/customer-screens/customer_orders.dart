import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/components/appbar_widgets.dart';

class CustomerOrders extends StatelessWidget {
  const CustomerOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTittle(title: 'Customer Orders'),
        leading: const AppBarButton(),
      ),
    );
  }
}
