import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_store_app/main_screens/customer_home.dart';
import 'package:multi_store_app/providers/cart_provider.dart';
import 'package:multi_store_app/providers/wish_provider.dart';
import 'package:multi_store_app/widgets/components/alart_dialog.dart';
import 'package:multi_store_app/widgets/components/appbar_widgets.dart';
import 'package:multi_store_app/widgets/components/yellow_button.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

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
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            leading: widget.back,
            backgroundColor: Colors.white,
            title: const AppBarTittle(title: 'Cart'),
            actions: [
              context.watch<Cart>().getItems.isEmpty
                  ? const SizedBox()
                  : IconButton(
                      onPressed: (() {
                        MyAlertDialog.showMyDialog(
                          context: context,
                          title: 'Clear cart',
                          message: 'Are you sure you want to clear cart ?',
                          tabNo: (() {
                            Navigator.pop(context);
                          }),
                          tabYes: (() {
                            context.read<Cart>().clearCart();
                            Navigator.pop(context);
                          }),
                        );
                      }),
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.black,
                      ),
                    )
            ],
          ),
          body: context.watch<Cart>().getItems.isNotEmpty
              ? const CartItems()
              : const EmptyCart(),
          bottomSheet: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text(
                      'Total: \$',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      ' ${context.watch<Cart>().totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
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

class EmptyCart extends StatelessWidget {
  const EmptyCart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}

class CartItems extends StatelessWidget {
  const CartItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) {
        return ListView.builder(
          itemCount: cart.count,
          itemBuilder: ((context, index) {
            final product = cart.getItems[index];
            return Padding(
              padding: const EdgeInsets.all(6.0),
              child: Card(
                child: SizedBox(
                  height: 100,
                  child: Row(children: [
                    SizedBox(
                      height: 100,
                      width: 120,
                      child: Image.network(product.imageUrl.first),
                    ),
                    Flexible(
                        child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                product.price.toStringAsFixed(2),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              Container(
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  children: [
                                    product.qty == 1
                                        ? IconButton(
                                            onPressed: (() {
                                              showCupertinoModalPopup<void>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        CupertinoActionSheet(
                                                  title: const Text('Remove'),
                                                  message: const Text(
                                                      'Are you sure you want to remove this item ?'),
                                                  actions: <
                                                      CupertinoActionSheetAction>[
                                                    CupertinoActionSheetAction(
                                                      /// This parameter indicates the action would be a default
                                                      /// defualt behavior, turns the action's text to bold text.
                                                      isDefaultAction: true,
                                                      onPressed: () async {
                                                        context
                                                                    .read<
                                                                        Wish>()
                                                                    .geWishItems
                                                                    .firstWhereOrNull(
                                                                        (element) =>
                                                                            element.documentId ==
                                                                            product
                                                                                .documentId) !=
                                                                null
                                                            ? context
                                                                .read<Cart>()
                                                                .removeItem(
                                                                    product)
                                                            : await context
                                                                .read<Wish>()
                                                                .addWishItem(
                                                                  product.name,
                                                                  product.price,
                                                                  1,
                                                                  product.qntty,
                                                                  product
                                                                      .imageUrl,
                                                                  product
                                                                      .documentId,
                                                                  product
                                                                      .suppId,
                                                                );
                                                        context
                                                            .read<Cart>()
                                                            .removeItem(
                                                                product);
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                          'Move to Wishlist'),
                                                    ),
                                                    CupertinoActionSheetAction(
                                                      /// This parameter indicates the action would perform
                                                      /// a destructive action such as delete or exit and turns
                                                      /// the action's text color to red.
                                                      isDestructiveAction: true,
                                                      onPressed: () {
                                                        context
                                                            .read<Cart>()
                                                            .removeItem(
                                                                product);
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                          'Delete Item'),
                                                    ),
                                                  ],
                                                  cancelButton: TextButton(
                                                    onPressed: (() {
                                                      Navigator.pop(context);
                                                    }),
                                                    child: const Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.red),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                            icon: const Icon(
                                              Icons.delete_forever,
                                              size: 18,
                                            ),
                                          )
                                        : IconButton(
                                            onPressed: (() {
                                              context
                                                  .read<Cart>()
                                                  .decrement(product);
                                            }),
                                            icon: const Icon(
                                              FontAwesomeIcons.minus,
                                              size: 18,
                                            ),
                                          ),
                                    Text(
                                      '${product.qty}',
                                      style: product.qty == product.qntty
                                          ? const TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'Acme',
                                              color: Colors.red,
                                            )
                                          : const TextStyle(
                                              fontSize: 20, fontFamily: 'Acme'),
                                    ),
                                    IconButton(
                                      onPressed: product.qty == product.qntty
                                          ? null
                                          : (() {
                                              context
                                                  .read<Cart>()
                                                  .increment(product);
                                            }),
                                      icon: const Icon(
                                        FontAwesomeIcons.plus,
                                        size: 18,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ))
                  ]),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
