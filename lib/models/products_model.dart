import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/minor_screen/product_details.dart';
import 'package:multi_store_app/providers/wish_provider.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class ProductModel extends StatefulWidget {
  const ProductModel({
    Key? key,
    required this.products,
    this.onPressed,
  }) : super(key: key);
  final dynamic products;
  final Function()? onPressed;

  @override
  State<ProductModel> createState() => _ProductModelState();
}

class _ProductModelState extends State<ProductModel> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => ProductDetailsScreen(
                      proList: widget.products,
                    ))));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Container(
                  constraints:
                      const BoxConstraints(maxHeight: 250, minHeight: 100),
                  child: Image.network(
                    widget.products['proimages'][0],
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      widget.products['proname'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.products['price'].toStringAsFixed(2) + ' \$',
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        widget.products['sid'] ==
                                FirebaseAuth.instance.currentUser!.uid
                            ? IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.red,
                                ))
                            : IconButton(
                                onPressed: () {
                                  context
                                              .read<Wish>()
                                              .geWishItems
                                              .firstWhereOrNull((product) =>
                                                  product.documentId ==
                                                  widget
                                                      .products['productid']) !=
                                          null
                                      ? context.read<Wish>().removeThis(
                                          widget.products['productid'])
                                      : context.read<Wish>().addWishItem(
                                            widget.products['proname'],
                                            widget.products['price'],
                                            1,
                                            widget.products['instock'],
                                            widget.products['proimages'],
                                            widget.products['productid'],
                                            widget.products['sid'],
                                          );
                                },
                                icon: context
                                            .watch<Wish>()
                                            .geWishItems
                                            .firstWhereOrNull((product) =>
                                                product.documentId ==
                                                widget.products['productid']) !=
                                        null
                                    ? const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      )
                                    : const Icon(
                                        Icons.favorite_border_outlined,
                                        color: Colors.red,
                                      ),
                              ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
