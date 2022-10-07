import 'package:flutter/material.dart';
import 'package:multi_store_app/main_screens/customer_home.dart';
import 'package:multi_store_app/main_screens/supplier_home.dart';

import 'package:multi_store_app/main_screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.welcomeScreen,
      routes: {
        WelcomeScreen.welcomeScreen: (context) => const WelcomeScreen(),
        CustomerHomeScreen.customerScreen: (context) =>
            const CustomerHomeScreen(),
        SupplierHomeScreen.supplierScreen: (context) =>
            const SupplierHomeScreen(),
      },
    );
  }
}
