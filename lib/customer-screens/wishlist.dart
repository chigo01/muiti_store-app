import 'package:flutter/material.dart';

import 'package:multi_store_app/models/wish_model.dart';
import 'package:multi_store_app/providers/wish_provider.dart';
import 'package:multi_store_app/widgets/components/alart_dialog.dart';
import 'package:multi_store_app/widgets/components/appbar_widgets.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<WishlistScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            leading: const AppBarButton(),
            backgroundColor: Colors.white,
            title: const AppBarTittle(title: 'Wishlist'),
            actions: [
              context.watch<Wish>().geWishItems.isEmpty
                  ? const SizedBox()
                  : IconButton(
                      onPressed: (() {
                        MyAlertDialog.showMyDialog(
                          context: context,
                          title: 'Clear wish',
                          message: 'Are you sure you want to clear wish ?',
                          tabNo: (() {
                            Navigator.pop(context);
                          }),
                          tabYes: (() {
                            context.read<Wish>().clearWishCart();
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
          body: context.watch<Wish>().geWishItems.isNotEmpty
              ? const WishItems()
              : const EmptyWishlist(),
        ),
      ),
    );
  }
}

class EmptyWishlist extends StatelessWidget {
  const EmptyWishlist({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Your WishList is Empty!',
            style: TextStyle(fontSize: 30),
          ),
        ],
      ),
    );
  }
}

class WishItems extends StatelessWidget {
  const WishItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Wish>(
      builder: (context, wish, child) {
        return ListView.builder(
          itemCount: wish.count,
          itemBuilder: ((context, index) {
            final product = wish.geWishItems[index];
            return WishlistModel(product: product);
          }),
        );
      },
    );
  }
}
