import 'package:flutter/material.dart';
import 'package:multi_store_app/main_screens/customer_home.dart';
import 'package:multi_store_app/widgets/components/appbar_widgets.dart';
import 'package:multi_store_app/widgets/components/yellow_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key, this.back}) : super(key: key);
  final Widget? back;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            leading: widget.back,
            backgroundColor: Colors.white,
            title: const AppBarTittle(title: 'Cart'),
            actions: [
              IconButton(
                onPressed: (() {}),
                icon: const Icon(
                  Icons.delete_forever,
                  color: Colors.black,
                ),
              )
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Your Cart is Empty!',
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 50),
                Material(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(25),
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width * 0.6,
                    onPressed: () {
                      Navigator.canPop(context)
                          ? Navigator.pop(context)
                          : Navigator.pushReplacementNamed(
                              //use to move to a screen when u intend not to pass information or move back bet both screens
                              context,
                              CustomerHomeScreen.customerScreen,
                            );
                    },
                    child: const Text(
                      'continue shopping',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          bottomSheet: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Text(
                      'Total: \$',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '00.00',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              YellowButton(
                label: 'CHECK OUT',
                onPressed: () {},
                width: 0.45,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
