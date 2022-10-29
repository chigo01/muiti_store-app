import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:multi_store_app/minor_screen/full_screen_view.dart';
import 'package:multi_store_app/models/products_model.dart';
import 'package:multi_store_app/widgets/components/yellow_button.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key? key, required this.proList})
      : super(key: key);
  final dynamic proList;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late List<dynamic> imageList = widget.proList['proimages'];
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
        .collection('products')
        .where('maincateg', isEqualTo: widget.proList['maincateg'])
        .where('subcateg', isEqualTo: widget.proList['subcateg'])
        .snapshots();
    return Material(
      child: SafeArea(
        //always wrap your safe area with materia widget if it is the parent widget of the build method t avoid black bars
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FullScreenView(imagesList: imageList),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.45,
                        child: Swiper(
                          pagination: const SwiperPagination(
                              builder: SwiperPagination.fraction),
                          itemBuilder: ((context, index) {
                            return Image.network(imageList[index]);
                          }),
                          itemCount: imageList.length,
                        ),
                      ),
                      Positioned(
                        left: 15,
                        top: 20,
                        child: CircleAvatar(
                          backgroundColor: Colors.yellow,
                          child: IconButton(
                            onPressed: (() {
                              Navigator.pop(context);
                            }),
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        //top right corner
                        right: 15,
                        top: 20,
                        child: CircleAvatar(
                          backgroundColor: Colors.yellow,
                          child: IconButton(
                            onPressed: (() {
                              Navigator.pop(context);
                            }),
                            icon: const Icon(
                              Icons.share,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.proList['proname'],
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'USD ',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                widget.proList['price'].toStringAsFixed(2),
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: (() {}),
                            icon: const Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        (widget.proList['instock'].toString()) +
                            ' Pieces avalaible in stock ',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.blueGrey,
                        ),
                      ),
                      const ProDetailHeader(label: '   Item Description   '),
                      Text(
                        widget.proList['prodesc'],
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.1,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueGrey.shade800,
                        ),
                      ),
                      const ProDetailHeader(label: '   Similar Items   '),
                      SizedBox(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: _productsStream,
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Something went wrong');
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(child: Text("Loading"));
                            }
                            if (snapshot.data!.docs.isEmpty) {
                              return const Center(
                                  child: Text(
                                'This category \n\n has no items yet!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 26,
                                  color: Colors.blueGrey,
                                  fontFamily: 'Acme',
                                  letterSpacing: 1.5,
                                ),
                              ));
                            }
                            return SingleChildScrollView(
                              child: StaggeredGridView.countBuilder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                crossAxisCount: 2,
                                itemBuilder: (context, index) {
                                  return ProductModel(
                                    products: snapshot.data!.docs[index],
                                  );
                                },
                                staggeredTileBuilder: (context) =>
                                    const StaggeredTile.fit(1),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: (() {}),
                      icon: const Icon(Icons.store),
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: (() {}),
                      icon: const Icon(Icons.shopping_cart),
                    ),
                  ],
                ),
                YellowButton(
                    width: 0.55, label: 'ADD TO CART ', onPressed: (() {}))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProDetailHeader extends StatelessWidget {
  const ProDetailHeader({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.yellow.shade900,
              thickness: 1,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.yellow.shade900,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.yellow.shade900,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
