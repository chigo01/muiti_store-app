import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/components/stream_body.dart';

class HomeAndGardenGalleryScreen extends StatefulWidget {
  const HomeAndGardenGalleryScreen({Key? key}) : super(key: key);

  @override
  State<HomeAndGardenGalleryScreen> createState() => _MenGalleryScreenState();
}

class _MenGalleryScreenState extends State<HomeAndGardenGalleryScreen> {
  final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
      .collection('products')
      .where('maincateg', isEqualTo: 'home & garden')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBody(productsStream: _productsStream);
  }
}
