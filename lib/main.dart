import 'package:flutter/material.dart';
import 'package:multi_store_app/auth/customer_login.dart';
import 'package:multi_store_app/auth/customer_signup.dart';
import 'package:multi_store_app/auth/supplier_login.dart';
import 'package:multi_store_app/auth/supplier_signup.dart';
import 'package:multi_store_app/main_screens/customer_home.dart';
import 'package:multi_store_app/main_screens/supplier_home.dart';

import 'package:multi_store_app/main_screens/welcome_screen.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
        CustomerRegister.signUp: (context) => const CustomerRegister(),
        CustomerLogin.login: (context) => const CustomerLogin(),
        SupplierLogin.login: (context) => const SupplierLogin(),
        SupplierRegister.suppliersUp: (context) => const SupplierRegister()
      },
    );
  }
}
